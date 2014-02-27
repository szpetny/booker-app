require 'spec_helper'

describe "books/index" do
  let(:user) {FactoryGirl.create(:user)}
  before(:each) do
    assign(:books, [FactoryGirl.create(:book), FactoryGirl.create(:book)])
    view.stub(:current_user).and_return(user)
    view.stub(:signed_in?).and_return(true)
  end
  
  it "renders a table of books for normal user" do
    render
    assert_select "h1", text: titleize(I18n.t(:books_index))
    assert_select "th", text: titleize(I18n.t(:title)), count: 1
    assert_select "th", text: titleize(I18n.t(:author)), count: 1
    assert_select "th", text: titleize(I18n.t(:photo)), count: 1
    assert_select "th", text: titleize(I18n.t(:quantity)), count: 1
    assert_select "th", text: titleize(I18n.t(:language)), count: 1
    assert_select "th", text: titleize(I18n.t(:place)), count: 1
    assert_select "tr>td", text: "Leszcz i Malgorzata", count: 2
    assert_select "tr>td", text: "Chlepton Grubson", count: 2
    assert_select "tr>td", text: "ruslanski", count: 2
    assert_select "tr>td", text: "1", count: 2
    assert_select "tr>td", text: "srodek jamnika", count: 2
  end
  
  it "renders a table of books for admin" do
    user.admin = true
    render
    assert_select "h1", text: titleize(I18n.t(:books_index))
    assert_select "th", text: titleize(I18n.t(:title)), count: 1
    assert_select "th", text: titleize(I18n.t(:author)), count: 1
    assert_select "th", text: titleize(I18n.t(:photo)), count: 1
    assert_select "th", text: titleize(I18n.t(:quantity)), count: 1
    assert_select "th", text: titleize(I18n.t(:language)), count: 1
    assert_select "th", text: titleize(I18n.t(:place)), count: 1
    assert_select "tr>td", text: "Leszcz i Malgorzata", count: 2
    assert_select "tr>td", text: "Chlepton Grubson", count: 2
    assert_select "tr>td", text: "ruslanski", count: 2
    assert_select "tr>td", text: "1", count: 2
    assert_select "tr>td", text: "srodek jamnika", count: 2
    assert_select 'a', text: titleize(I18n.t(:edit)), count: 2
    assert_select 'a', text: titleize(I18n.t(:destroy)), count: 2
  end
end
