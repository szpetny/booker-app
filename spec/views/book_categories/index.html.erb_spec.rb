require 'spec_helper'

describe "book_categories/index" do
  before(:each) do
    assign(:book_categories, [
      stub_model(BookCategory,
        :category_name => "Category Name"
      ),
      stub_model(BookCategory,
        :category_name => "Category Name"
      )
    ])
  end

  it "renders a list of book_categories" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Category Name".to_s, :count => 2
  end
end
