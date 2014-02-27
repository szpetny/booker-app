require 'spec_helper'

describe "books/show" do
  let(:user) {FactoryGirl.create(:user)}
  before(:each) do
    view.stub(:current_user).and_return(user)
    view.stub(:signed_in?).and_return(true)
    @book = assign(:book, FactoryGirl.build(:book))
    @book_category =  FactoryGirl.build(:book_category)
    @book.book_categories << @book_category
  end

  it "show book for a normal user" do
    render
    #rendered.should match(/Category Name/)
    expect(rendered).to have_selector('h1', text: @book.title)
    expect(rendered).to have_selector('p', text: @book.author.name_and_surname)
    expect(rendered).to have_selector('p', text: @book_category.category_name)
    expect(rendered).to have_selector('p', text: @book.isbn)
    expect(rendered).to have_selector('p', text: @book.language)
    expect(rendered).to have_selector('p', text: @book.description)
    expect(rendered).to have_selector('p', text: @book.quantity)
    expect(rendered).to have_selector('p', text: @book.place)
    expect(rendered).to have_selector('p', text: @book.release_date)
    expect(rendered).to have_selector('p', text: @book.pages)
    expect(rendered).to have_selector('a', text: titleize(I18n.t(:back)))
  end
  
  it "show book for an admin" do
    user.admin = true
    render
    expect(rendered).to have_selector('h1', text: @book.title)
    expect(rendered).to have_selector('p', text: @book.author.name_and_surname)
    expect(rendered).to have_selector('p', text: @book_category.category_name)
    expect(rendered).to have_selector('p', text: @book.isbn)
    expect(rendered).to have_selector('p', text: @book.language)
    expect(rendered).to have_selector('p', text: @book.description)
    expect(rendered).to have_selector('p', text: @book.quantity)
    expect(rendered).to have_selector('p', text: @book.place)
    expect(rendered).to have_selector('p', text: @book.release_date)
    expect(rendered).to have_selector('p', text: @book.pages)
    expect(rendered).to have_selector('a', text: titleize(I18n.t(:edit)))
    expect(rendered).to have_selector('a', text: titleize(I18n.t(:back)))
  end
end
