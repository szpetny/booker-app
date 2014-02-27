require 'spec_helper'

describe "authors/edit" do
  before do
    @author = assign(:author, FactoryGirl.create(:author))
  end

  it "renders the edit author form" do
    render
    assert_select "h1", text: titleize(I18n.t(:edit_author))
    assert_select "form[action=?][method=?]", author_path(@author), "post" do
      assert_select "input#author_name[name=?][value=?]", "author[name]", "Chlepton"
      assert_select "input#author_surname[name=?][value=?]", "author[surname]", "Grubson"
      assert_select "input[type='submit']"
    end
    assert_select 'a', text: titleize(I18n.t(:show)), count: 1
    assert_select 'a', text: titleize(I18n.t(:back)), count: 1
  end
end
