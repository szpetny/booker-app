require 'spec_helper'

describe "sessions/new" do
  it "renders the new session form" do
    render
    assert_select "h1", text: titleize(I18n.t(:sign_in))
    assert_select "form[action=?][method=?]", sessions_path, "post" do
      assert_select "input#session_email[name=?]", "session[email]"
      assert_select "input#session_password[name=?]", "session[password]"
      assert_select "input[type='submit']"
    end
    assert_select 'a', text: titleize(I18n.t(:sign_up)), count: 1
  end
end
