require 'spec_helper'

describe "User pages" do

  subject { page }
  
  describe "index" do
    let(:admin) { FactoryGirl.create(:admin) }
    before(:each) do
      sign_in admin
      visit users_path
    end

    it { should have_title(titleize(I18n.t(:users_index))) }
    it { should have_content(titleize(I18n.t(:users_index))) }

    describe "pagination" do
      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all)  { User.delete_all }

      it { should have_selector('div.pagination') }

      it "should list each user" do
        User.paginate(page: 1).each do |user|
          expect(page).to have_css('a', text: user.name)
        end
      end
    end
    
    describe "delete links" do
      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        let(:user) {FactoryGirl.create(:user)}
        before do
          user.save
          ApplicationController.any_instance.stub(:current_user).and_return(admin)
          sign_in admin
          visit users_path
        end

        it { should have_link(titleize(I18n.t(:destroy)), href: user_path(user)) }
        it "should be able to delete another user" do
          expect do
            click_link(titleize(I18n.t(:destroy)), match: :first)
          end.to change(User, :count).by(-1)
        end
        it { should_not have_link(titleize(I18n.t(:destroy)), href: user_path(admin)) }
      end
    end
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before do
       ApplicationController.any_instance.stub(:current_user).and_return(user)
       visit user_path(user) 
    end

    it { should have_content(user.name) }
    it { should have_title(user.name) }
  end

  describe "signup page" do
    before { visit signup_path }

    it { should have_content(titleize(I18n.t(:sign_up))) }
    it { should have_title(full_title(titleize(I18n.t(:sign_up)))) }
  end

  describe "signup" do
    before { visit signup_path }

    let(:submit) {titleize(I18n.t(:create_account))}

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end
      
      describe "after submission" do
        before { click_button submit }

        it { should have_title(titleize(I18n.t(:sign_up))) }
        it { should have_css('div.has-error') }
      end
    end

    describe "with valid information" do
      before do
        fill_in titleize(I18n.t(:name)), with: "User"
        fill_in titleize(I18n.t(:surname)), with: "Example"
        fill_in titleize(I18n.t(:email)), with: "user@example.com"
        fill_in titleize(I18n.t(:password)), with: "foobar"
        fill_in titleize(I18n.t(:password_confirmation)), with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end
      
      describe "after saving the user" do
        before { click_button submit }
        let(:user) { User.find_by(email: 'user@example.com') }

        it { should have_link(titleize(I18n.t(:sign_out))) }
        it { should have_title(user.name) }
        it { should have_selector('div.alert.alert-success', text: I18n.t(:welcome)) }
      end
    end
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      sign_in user
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_content(titleize(I18n.t(:edit_profile))) }
      it { should have_title(titleize(I18n.t(:edit_profile))) }
    end

    describe "with invalid information" do
      before { click_button titleize(I18n.t(:save)) }

      it { should have_css('div.alert-info') }
    end
    
    describe "with valid information" do
      let(:new_name)  { "New Name" }
      let(:new_surname)  { "New SurName" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in titleize(I18n.t(:name)),             with: new_name
        fill_in titleize(I18n.t(:surname)),             with: new_surname
        fill_in titleize(I18n.t(:email)),            with: new_email
        fill_in titleize(I18n.t(:password)),         with: user.password
        fill_in titleize(I18n.t(:password_confirmation)), with: user.password
        click_button titleize(I18n.t(:save))
      end

      it { should have_title(new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link(titleize(I18n.t(:sign_out)), href: signout_path) }
      specify { expect(user.reload.name).to  eq new_name }
      specify { expect(user.reload.email).to eq new_email }
    end
    
    describe "forbidden attributes" do
      let(:params) do
        { user: { admin: true, password: user.password,
                  password_confirmation: user.password } }
      end
      let(:admin) {FactoryGirl.create(:admin)}
      before do
        ApplicationController.any_instance.stub(:current_user).and_return(admin)
        patch user_path(user), params 
      end
      specify { expect(user.reload).not_to be_admin }
    end
  end
end