require 'spec_helper'

describe "authors/new" do
  before do
    @author = Author.new
  end

  it "renders the new author form" do
    render
    assert_select "h1", text: titleize(I18n.t(:add_author))
    assert_select "form[action=?][method=?]", authors_path, "post" do
      assert_select "input#author_name[name=?]", "author[name]"
      assert_select "input#author_surname[name=?]", "author[surname]"
      assert_select "input[type='submit']"
    end
    assert_select 'a', text: titleize(I18n.t(:back)), count: 1
  end
end
