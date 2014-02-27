require 'spec_helper'

describe "layouts/application" do
  describe "renders a _header for non-signed in user" do
    before do
      view.stub(:current_user).and_return(nil)
      view.stub(:signed_in?).and_return(false)
    end
    
    it  do
      render
      expect(rendered).to have_selector("a#logo", text: I18n.t(:books_index))
      expect(rendered).to have_selector("li>a", text: titleize(I18n.t(:sign_in)))
      expect(rendered).to have_selector("a", text: titleize(I18n.t(:help)))
      
      expect(rendered).to_not have_selector("a", text: titleize(I18n.t(:books)))
      expect(rendered).to_not have_selector("li>a", text: titleize(I18n.t(:books_index)))
      expect(rendered).to_not have_selector("li>a", text: titleize(I18n.t(:add_book)))
      expect(rendered).to_not have_selector("a", text: titleize(I18n.t(:book_categories)))
      expect(rendered).to_not have_selector("a", text: titleize(I18n.t(:authors)))
      expect(rendered).to_not have_selector("li>a", text: titleize(I18n.t(:authors_index)))
      expect(rendered).to_not have_selector("li>a", text: titleize(I18n.t(:add_author)))
      expect(rendered).to_not have_selector("a", text: titleize(I18n.t(:users_index)))
      expect(rendered).to_not have_selector("a", text: titleize(I18n.t(:account)))
      expect(rendered).to_not have_selector("li>a", text: titleize(I18n.t(:profile)))
      expect(rendered).to_not have_selector("li>a", text: titleize(I18n.t(:settings)))
      expect(rendered).to_not have_selector("li>a", text: titleize(I18n.t(:sign_out)))
    end
  end
  
  describe "renders a _header for signed in user" do
    let(:user) {FactoryGirl.create(:user)}
    before do
      view.stub(:current_user).and_return(user)
      view.stub(:signed_in?).and_return(true)
    end
    it  do
      render
      expect(rendered).to have_selector("a#logo", text: I18n.t(:books_index))
      expect(rendered).to have_selector("a", text: titleize(I18n.t(:books)))
      expect(rendered).to have_selector("li>a", text: titleize(I18n.t(:books_index)))
      expect(rendered).to_not have_selector("li>a", text: titleize(I18n.t(:add_book)))
      expect(rendered).to have_selector("a", text: titleize(I18n.t(:book_categories)))
      expect(rendered).to have_selector("a", text: titleize(I18n.t(:authors)))
      expect(rendered).to have_selector("li>a", text: titleize(I18n.t(:authors_index)))
      expect(rendered).to_not have_selector("li>a", text: titleize(I18n.t(:add_author)))
      expect(rendered).to_not have_selector("a", text: titleize(I18n.t(:users_index)))
      expect(rendered).to have_selector("a", text: titleize(I18n.t(:account)))
      expect(rendered).to have_selector("li>a", text: titleize(I18n.t(:profile)))
      expect(rendered).to have_selector("li>a", text: titleize(I18n.t(:settings)))
      expect(rendered).to have_selector("li>a", text: titleize(I18n.t(:sign_out)))
      expect(rendered).to have_selector("a", text: titleize(I18n.t(:help)))
      
      expect(rendered).to_not have_selector("li>a", text: titleize(I18n.t(:sign_in)))
    end
  end
  
  describe "renders a _header for an admin" do
    let(:admin) {FactoryGirl.create(:admin)}
    before do
      view.stub(:current_user).and_return(admin)
      view.stub(:signed_in?).and_return(true)
    end
    it  do
      render
      expect(rendered).to have_selector("a#logo", text: I18n.t(:books_index))
      expect(rendered).to have_selector("a", text: titleize(I18n.t(:books)))
      expect(rendered).to have_selector("li>a", text: titleize(I18n.t(:books_index)))
      expect(rendered).to have_selector("li>a", text: titleize(I18n.t(:add_book)))
      expect(rendered).to have_selector("a", text: titleize(I18n.t(:book_categories)))
      expect(rendered).to have_selector("a", text: titleize(I18n.t(:authors)))
      expect(rendered).to have_selector("li>a", text: titleize(I18n.t(:authors_index)))
      expect(rendered).to have_selector("li>a", text: titleize(I18n.t(:add_author)))
      expect(rendered).to have_selector("a", text: titleize(I18n.t(:users_index)))
      expect(rendered).to have_selector("a", text: titleize(I18n.t(:account)))
      expect(rendered).to have_selector("li>a", text: titleize(I18n.t(:profile)))
      expect(rendered).to have_selector("li>a", text: titleize(I18n.t(:settings)))
      expect(rendered).to have_selector("li>a", text: titleize(I18n.t(:sign_out)))
      expect(rendered).to have_selector("a", text: titleize(I18n.t(:help)))
      
      expect(rendered).to_not have_selector("li>a", text: titleize(I18n.t(:sign_in)))
    end
  end
end
