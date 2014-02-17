require 'spec_helper'

describe Book do

  let(:author) { FactoryGirl.create(:author) }
  before do
    @book = author.books.build(isbn: "83-07-0234204",
                     title: "Mistrz i Malgorzata",
                     author_id: author.id,
                     language: "polski",
                     description: "Mistrz i Malgorzata",
                     quantity: 1,
                     place: "wewnatrz jamnika",
                     pages: 476)
  end

  subject { @book }

  it { should respond_to(:isbn) }
  it { should respond_to(:author_id) }
  it { should respond_to(:title) }
  it { should respond_to(:language) }
  it { should respond_to(:description) }
  it { should respond_to(:quantity) }
  it { should respond_to(:place) }
  it { should respond_to(:pages) }
  it { should respond_to(:author) }
  it { should respond_to(:book_categories) }
  its(:author) { should eq author }

  it { should be_valid }

  describe "when author_id is not present" do
    before { @book.author_id = nil }
    it { should_not be_valid }
  end
  
  describe "when isbn is not present" do
    before { @book.isbn = nil }
    it { should_not be_valid }
  end
  
  describe "when isbn is not a number with hyphens" do
    before { @book.isbn = "nil" }
    it { should_not be_valid }
  end
  
  describe "when title is not present" do
    before { @book.title = nil }
    it { should_not be_valid }
  end
  
  describe "when quantity is not present" do
    before { @book.quantity = nil }
    it { should be_valid }
  end
  
  describe "when quantity is not a number" do
    before { @book.quantity = "nil" }
    it { should_not be_valid }
  end
  
  describe "when pages is not present" do
    before { @book.pages = nil }
    it { should be_valid }
  end
  
  describe "when pages is not a number" do
    before { @book.pages = "nil" }
    it { should_not be_valid }
  end
  
  describe "when place is not present" do
    before { @book.place = nil }
    it { should_not be_valid }
  end
  
  describe "when release date is not present" do
    before { @book.release_date = nil }
    it { should be_valid }
  end
end