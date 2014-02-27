require 'spec_helper'

describe "authors/index" do
  let(:user) {FactoryGirl.create(:user)}
  before(:each) do
    assign(:authors, [FactoryGirl.create(:author, name: "Bolek", surname: "Fredzel"), 
                      FactoryGirl.create(:author)])
    view.stub(:current_user).and_return(user)
    view.stub(:signed_in?).and_return(true)
    view.stub(:will_paginate).and_return(false)   
  end
  
  it "renders a table of authors for normal user" do
    render
    assert_select "h1", text: titleize(I18n.t(:authors_index))
    assert_select "input#author_search", count: 1
    assert_select "div.col-md-3", text: "Fredzel Bolek", count: 1
    assert_select "div.col-md-3", text: "Grubson Chlepton", count: 1
    assert_select 'a', text: titleize(I18n.t(:author_books)), count: 2
  end
  
  it "renders a table of authors for admin" do
    user.admin = true
    render
    assert_select "h1", text: titleize(I18n.t(:authors_index))
    assert_select "input#author_search", count: 1
    assert_select "div.col-md-3", text: "Fredzel Bolek", count: 1
    assert_select "div.col-md-3", text: "Grubson Chlepton", count: 1
    assert_select 'a', text: titleize(I18n.t(:author_books)), count: 2
    assert_select 'a', text: titleize(I18n.t(:edit)), count: 2
    assert_select 'a', text: titleize(I18n.t(:destroy)), count: 2
    assert_select 'a', text: titleize(I18n.t(:add_author)), count: 1
  end
end
