require 'spec_helper'

describe "users/edit" do
  before do
    @user = assign(:user, FactoryGirl.create(:user, name: "Zenon", surname: "Brzoza", email: "zenek@i.com"))
  end

  it "renders the edit user form" do
    render
    assert_select "h1", text: titleize(I18n.t(:edit_profile))
    assert_select "form[action=?][method=?]", user_path(@user), "post" do
      assert_select "input#user_name[name=?][value=?]", "user[name]", "Zenon"
      assert_select "input#user_surname[name=?][value=?]", "user[surname]", "Brzoza"
      assert_select "input#user_email[name=?][value=?]", "user[email]", "zenek@i.com"
      assert_select "input#user_password[name=?][type='password']", "user[password]", ""
      assert_select "input#user_password_confirmation[name=?][type='password']", "user[password_confirmation]", ""
      assert_select "input[type='submit']"
    end
    assert_select 'a', text: titleize(I18n.t(:back)), count: 1
  end
end
