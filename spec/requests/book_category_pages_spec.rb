require 'spec_helper'

describe "Book categories pages" do

  subject {page}
  
  describe "index" do
    let(:user) {FactoryGirl.create(:user)}
    let(:book_category) {FactoryGirl.create(:book_category)}
    
    before(:each) do
      sign_in user
      visit book_categories_path
    end

    it {should_not have_link(titleize(I18n.t(:destroy)), href: book_category_path(BookCategory.first))}

    describe "delete links" do
      it {should_not have_link(titleize(I18n.t(:destroy)))}

      describe "as an admin user" do
        let(:admin) {FactoryGirl.create(:admin)}
        before do
          book_category.save
          sign_in admin
          visit book_categories_path
        end

        it {should have_link(titleize(I18n.t(:destroy)), href: book_category_path(BookCategory.first))}
        it "should be able to delete another book" do
          expect do
            click_link(titleize(I18n.t(:destroy)), match: :first)
          end.to change(BookCategory, :count).by(-1)
        end
      end
    end
  end

end