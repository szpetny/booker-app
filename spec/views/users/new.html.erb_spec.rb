require 'spec_helper'

describe "users/new" do
  before do
    @user = User.new
  end

  it "renders the new user form" do
    render
    assert_select "h1", text: titleize(I18n.t(:sign_up))
    assert_select "form[action=?][method=?]", users_path, "post" do
      assert_select "input#user_name[name=?]", "user[name]"
      assert_select "input#user_surname[name=?]", "user[surname]"
      assert_select "input#user_email[name=?]", "user[email]"
      assert_select "input#user_password[name=?]", "user[password]"
      assert_select "input#user_password_confirmation[name=?]", "user[password_confirmation]"
      assert_select "input[type='submit']"
    end
  end
end
