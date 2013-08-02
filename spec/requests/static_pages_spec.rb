require 'spec_helper'

describe "StaticPages" do
=begin
describe "GET /static_pages" do
it "works! (now write some real specs)" do
# Run the generator again with the --webrat flag if you want to use webrat methods/matchers
get static_pages_index_path
response.status.should be(200)
end
end
=end
  subject { page }
  
  describe "Home page" do
    before { visit root_path }
    
    it { should have_content(I18n.t(:main_app_title)) }
    it { should have_title(full_title("Home")) }
  end

  describe "Help page" do
    before { visit help_path }
    
    it { should have_content('Help') }
    it { should have_title(full_title("Help")) }
  end
end
