require 'spec_helper'

describe "books/edit" do
  before do
    @book = assign(:book, FactoryGirl.create(:book))
    assign(:book_categories, [FactoryGirl.create(:book_category, category_name: "Podkolanowki Romana"), 
                              FactoryGirl.create(:book_category)])
  end

  it "renders the edit book form" do
    render
    assert_select "h1", text: titleize(I18n.t(:edit_book))
    assert_select "form[action=?][method=?]", book_path(@book), "post" do
      assert_select "input#book_title[name=?][value=?]", "book[title]", "Leszcz i Malgorzata"
      assert_select "select#book_author_id[name=?] option[selected='selected']", "book[author_id]", text: "Grubson Chlepton"
      assert_select "button", text: titleize(I18n.t(:add_author))
      assert_select "select#book_category_ids[name=?]", "book_category_ids[]"
      assert_select "button#add_category"
      assert_select "input#book_isbn[name=?][value=?]", "book[isbn]", "83-07-0234204"
      assert_select "input#book_language[name=?][value=?]", "book[language]", "ruslanski"
      assert_select "textarea#book_description[name=?]", "book[description]", text: "nudny opis po rumunsku"
      assert_select "input#book_quantity[name=?][value=?]", "book[quantity]", "1"
      assert_select "input#book_place[name=?][value=?]", "book[place]", "srodek jamnika"
      assert_select "input#release_date[name=?][value=?]", "book[release_date]", "1986-04-26"
      assert_select "input#book_pages[name=?][value=?]", "book[pages]", "476"
      assert_select "input#book_photo[name=?]", "book[photo]"
      assert_select "input[type='submit']"
    end
    assert_select "div.panel-heading", text: titleize(I18n.t(:current_photo)) + ":"
    assert_select 'a', text: titleize(I18n.t(:show)), count: 1
    assert_select 'a', text: titleize(I18n.t(:back)), count: 1
  end
end
