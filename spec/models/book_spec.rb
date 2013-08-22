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
                     place: "polka u Gosi",
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
  its(:author) { should eq author }

  it { should be_valid }

  describe "when author_id is not present" do
    before { @book.author_id = nil }
    it { should_not be_valid }
  end
end