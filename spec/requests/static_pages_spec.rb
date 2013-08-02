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
  
  
   describe "Home page" do
    it "should have the content" + I18n.t(:main_app_title) do
      visit '/static_pages/home'
      expect(page).to have_content(I18n.t(:main_app_title))
    end
    
    it "should have the title 'Home'" do
      visit '/static_pages/home'
      expect(page).to have_title(I18n.t(:main_app_title) + " | Home")
    end
  end
  
  describe "Help page" do
    it "should have the content 'Help'" do
      visit '/static_pages/help'
      expect(page).to have_content('Help')
    end
    
    it "should have the title 'Help'" do
      visit '/static_pages/help'
      expect(page).to have_title(I18n.t(:main_app_title) + " | Help")
    end
  end
end
