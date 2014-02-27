require 'spec_helper'

describe "Book pages" do

  subject {page}
  
  describe "index for a normal user" do
    let(:user) {FactoryGirl.create(:user)}
    let(:book) {FactoryGirl.create(:book)}
    
    before do
      book.save
      sign_in user
      visit books_path
    end
    
    it {should have_content(titleize(I18n.t(:books_index)))}
    it {should have_content(book.title)}
    it {should_not have_link(titleize(I18n.t(:add_book)))}
    it {should have_link(titleize(I18n.t(:show)), href: book_path(book))}
    it {should_not have_link(titleize(I18n.t(:edit)), href: edit_book_path(book))}
    it {should_not have_link(titleize(I18n.t(:destroy)))}
  end
  
  describe "index for an admin" do
    let(:admin) {FactoryGirl.create(:admin)}
    let(:book) {FactoryGirl.create(:book)}
    
    before do
      book.save
      sign_in admin
      visit books_path
    end
    
    it {should have_content(titleize(I18n.t(:books_index)))}
    it {should have_content(book.title)}
    it {should have_link(titleize(I18n.t(:add_book)))}
    it {should have_link(titleize(I18n.t(:show)), href: book_path(book))}
    it {should have_link(titleize(I18n.t(:edit)), href: edit_book_path(book))}
    it {should have_link(titleize(I18n.t(:destroy)), href: book_path(book))}
  end

end