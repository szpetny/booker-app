require 'spec_helper'

describe "Book pages" do

  subject { page }
  
  describe "index" do
    let(:user) { FactoryGirl.create(:user) }
    let(:book) { FactoryGirl.create(:book) }
    
    before do
      visit root_path
    end
    
    describe "add book is invisible for not signed users" do
      it { should_not have_link(titleize(I18n.t(:add_book))) }
    end
    
    before do
      sign_in user
      visit books_path
    end

    describe "add book" do
      describe "when user is not an admin" do
        it { should_not have_link(titleize(I18n.t(:add_book))) }
      end
      
      describe "as an admin" do
        let(:admin) { FactoryGirl.create(:admin) }
        
        before do
          sign_in admin
          visit books_path
        end
        
        it { should have_link(titleize(I18n.t(:add_book))) }
      end
    end
    
    describe "delete links" do
      it { should_not have_link(titleize(I18n.t(:destroy))) }

      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit books_path
        end

        it { should have_link(titleize(I18n.t(:destroy)), href: book_path(Book.first)) }
        it "should be able to delete another book" do
          expect do
            click_link(titleize(I18n.t(:destroy)), match: :first)
          end.to change(Book, :count).by(-1)
        end
      end
    end
  end

end