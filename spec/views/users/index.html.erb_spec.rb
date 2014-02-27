require 'spec_helper'

describe "users/index" do
  let(:admin) {FactoryGirl.create(:admin)}
  before(:each) do
    assign(:users, [FactoryGirl.build(:user, name: "Towarzysz"), FactoryGirl.build(:user, name: "Bolek")])
    view.stub(:current_user).and_return(admin)
    view.stub(:signed_in?).and_return(true)
    view.stub(:will_paginate).and_return(false)   
  end
  
  it "renders a table of users for admin" do
    render
    assert_select "h1", text: titleize(I18n.t(:users_index))
    assert_select "div.col-md-3", text: "Towarzysz", count: 1
    assert_select "div.col-md-3", text: "Bolek", count: 1
    assert_select 'a', text: titleize(I18n.t(:edit)), count: 2
    assert_select 'a', text: titleize(I18n.t(:destroy)), count: 2
  end
end
