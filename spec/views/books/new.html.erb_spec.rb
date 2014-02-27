require 'spec_helper'

describe "books/new" do
  before do
    @book = Book.new
    assign(:book_categories, [FactoryGirl.create(:book_category), FactoryGirl.create(:book_category)])
  end

  it "renders the new book form" do
    render
    assert_select "h1", text: titleize(I18n.t(:add_book))
    assert_select "form[action=?][method=?]", books_path, "post" do
      assert_select "input#book_title[name=?]", "book[title]"
      assert_select "select#book_author_id[name=?]", "book[author_id]"
      assert_select "button", text: titleize(I18n.t(:add_author))
      assert_select "select#book_category_ids[name=?]", "book_category_ids[]"
      assert_select "button#add_category"
      assert_select "input#book_isbn[name=?]", "book[isbn]"
      assert_select "input#book_language[name=?]", "book[language]"
      assert_select "textarea#book_description[name=?]", "book[description]"
      assert_select "input#book_quantity[name=?]", "book[quantity]"
      assert_select "input#book_place[name=?]", "book[place]"
      assert_select "input#release_date[name=?]", "book[release_date]"
      assert_select "input#book_pages[name=?]", "book[pages]"
      assert_select "input#book_photo[name=?]", "book[photo]"
      assert_select "input[type='submit']"
    end
    assert_select "div.panel-heading", text: titleize(I18n.t(:current_photo)) + ":"
    assert_select 'a', text: titleize(I18n.t(:back)), count: 1
  end
end
