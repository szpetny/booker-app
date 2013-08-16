require 'spec_helper'

describe "StaticPages" do

  subject { page }
  
  shared_examples_for "all static pages" do
    it { should have_title(full_title(page_title)) }
  end
  
  describe "Home page" do
    before { visit home_path }
    
    let(:heading)    { full_title(titleize(I18n.t(:home))) }
    let(:page_title) { titleize(I18n.t(:home)) }

    it_should_behave_like "all static pages"
  end

  describe "Help page" do
    before { visit help_path }
    
    let(:heading)    { full_title(titleize(I18n.t(:help))) }
    let(:page_title) { titleize(I18n.t(:help)) }

    it_should_behave_like "all static pages"
  end
  
  it "should have the right links on the layout" do
    visit root_path
    click_link titleize(I18n.t(:help))
    expect(page).to have_title(full_title(titleize(I18n.t(:help))))
    click_link titleize(I18n.t(:home))
    expect(page).to have_title(full_title(titleize(I18n.t(:home))))
    click_link titleize(I18n.t(:sign_in))
    expect(page).to have_title(full_title(titleize(I18n.t(:sign_in))))
    click_link I18n.t(:books_index)
    expect(page).to have_title(full_title(''))
  end
end
