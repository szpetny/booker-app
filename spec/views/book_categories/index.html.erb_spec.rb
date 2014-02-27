require 'spec_helper'
require 'pp'

describe "book_categories/index" do
  let(:user) {FactoryGirl.create(:user)}
  before do
    assign(:book_categories, [FactoryGirl.create(:book_category), FactoryGirl.create(:book_category)])
    view.stub(:current_user).and_return(user)
    view.stub(:signed_in?).and_return(true)
  end

  it "renders a list of book_categories for normal user" do
    render
    assert_select "h1", text: titleize(I18n.t(:book_categories))
    assert_select 'div.col-md-3', text: "Skarpety Romana".to_s, count: 2
  end
  
  it "renders also delete link when admin_user" do
    user.admin = true
    render
    assert_select "h1", text: titleize(I18n.t(:book_categories))
    assert_select 'div.col-md-3', text: "Skarpety Romana".to_s, count: 2
    assert_select 'a', text: titleize(I18n.t(:destroy)), count: 2
  end
end
