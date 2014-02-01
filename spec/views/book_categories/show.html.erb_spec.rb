require 'spec_helper'

describe "book_categories/show" do
  before(:each) do
    @book_category = assign(:book_category, stub_model(BookCategory,
      :category_name => "Category Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Category Name/)
  end
end
