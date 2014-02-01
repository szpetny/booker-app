require 'spec_helper'

describe "book_categories/edit" do
  before(:each) do
    @book_category = assign(:book_category, stub_model(BookCategory,
      :category_name => "MyString"
    ))
  end

  it "renders the edit book_category form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", book_category_path(@book_category), "post" do
      assert_select "input#book_category_category_name[name=?]", "book_category[category_name]"
    end
  end
end
