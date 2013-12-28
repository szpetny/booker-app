require 'spec_helper'
require 'pp'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { should have_content(titleize(I18n.t(:sign_in))) }
    it { should have_title(titleize(I18n.t(:sign_in))) }
  end

  describe "signin" do
    before { visit signin_path }

    describe "with invalid information" do
      before { click_button titleize(I18n.t(:sign_in)) }

      it { should have_title(titleize(I18n.t(:sign_in))) }
      it { should have_error_message('Invalid') }

      describe "after visiting another page" do
        before { click_link titleize(I18n.t(:help)) }
        it { should_not have_selector('div.alert.alert-danger') }
      end
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before { valid_signin(user) }

      it { should have_title(titleize(I18n.t(:books_index))) }
      it { should have_link(titleize(I18n.t(:users_index)), href: users_path) }
      it { should have_link(titleize(I18n.t(:authors_index)), href: authors_path) }
      it { should_not have_link(titleize(I18n.t(:add_author)), href: new_author_path) }
      it { should have_link(titleize(I18n.t(:books_index)), href: books_path) }
      it { should_not have_link(titleize(I18n.t(:add_book)), href: new_book_path) }
      it { should have_link(titleize(I18n.t(:profile)),     href: user_path(user)) }
      it { should have_link(titleize(I18n.t(:settings)),    href: edit_user_path(user)) }
      it { should have_link(titleize(I18n.t(:sign_out)),    href: signout_path) }
      it { should_not have_link(titleize(I18n.t(:sign_in)), href: signin_path) }

      describe "followed by signout" do
        before { click_link titleize(I18n.t(:sign_out)) }
        it { should have_link(titleize(I18n.t(:sign_in))) }
      end
    end
  end

  describe "authorization" do
    describe "as non-admin user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:non_admin) { FactoryGirl.create(:user) }

      before { sign_in non_admin, no_capybara: true }

      describe "submitting a DELETE request to the Users#destroy action" do
        before { delete user_path(user) }
        specify { expect(response).to redirect_to(root_url) }
      end
    end

    describe "as an admin can see add links in top menu" do
      let(:admin) {FactoryGirl.create(:admin)}
      let(:book) {FactoryGirl.create(:book)}
      
      before do
        visit root_path
        sign_in admin
      end
      
      it { should have_link(titleize(I18n.t(:authors_index)), href: authors_path) }
      it { should have_link(titleize(I18n.t(:add_author)), href: new_author_path) }
      it { should have_link(titleize(I18n.t(:books_index)), href: books_path) }
      it { should have_link(titleize(I18n.t(:add_book)), href: new_book_path) }
    end
  
    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

=begin
      describe "when attempting to visit a protected page" do
              before do
                visit edit_user_path(user)
                fill_in titleize(I18n.t(:email)),    with: user.email
                fill_in titleize(I18n.t(:password)), with: user.password
                click_button titleize(I18n.t(:sign_in))
              end
      
              describe "after signing in" do
                it "should render the desired protected page" do
                  expect(page).to have_title(full_title(titleize(I18n.t(:edit_user))))
                end
              end
              
              describe "when signing in again" do
                before do
                  delete signout_path
                  visit signin_path
                  fill_in "Email",    with: user.email
                  fill_in "Password", with: user.password
                 click_button "Sign in"
                end          
              
                it "should render the default (profile) page" do
                  expect(page).to have_title(user.name)
                end
              end           
            end
=end
      

      describe "in the Users controller" do
        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_title(titleize(I18n.t(:sign_in))) }
        end

        describe "submitting to the update action" do
          before { patch user_path(user) }
          specify { expect(response).to redirect_to(signin_path) }
        end
        
        describe "visiting the user index" do
          before { visit users_path }
          it { should have_title(titleize(I18n.t(:sign_in))) }
        end
      end
    end
    
    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
      before { sign_in user, no_capybara: true }

      describe "visiting Users#edit page" do
        before { visit edit_user_path(wrong_user) }
        it { should_not have_title(full_title(titleize(I18n.t(:edit_user)))) }
      end

      describe "submitting a PATCH request to the Users#update action" do
        before { patch user_path(wrong_user) }
        specify { expect(response).to redirect_to(root_url) }
      end
    end
  end

end