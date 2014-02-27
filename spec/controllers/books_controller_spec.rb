require 'spec_helper'

describe BooksController do
  let(:invalid_attributes) {FactoryGirl.attributes_for(:book, title: "", isbn: "").stringify_keys}
  let(:admin) {FactoryGirl.create(:admin)}
  let(:user) {FactoryGirl.create(:user)}
  
  def before_actions_for_user
    sign_in(user)
    controller.stub!(:signed_in_user).and_return(true)
  end  
  
  def before_actions_for_admin 
    sign_in(admin)
    controller.stub!(:signed_in_user).and_return(true)
    controller.stub!(:admin_user).and_return(true)
  end  
  
  describe "GET index" do
    let(:book) {FactoryGirl.create(:book)}
    let(:author) {FactoryGirl.create(:author)}
    before(:each) do
      before_actions_for_user
    end
    
    it "assigns author's books as @books" do
      author.books << book
      params = {author_id: author.id}
      get :index, params
      assigns(:books).should eq([book])
    end
    
    it "assigns all books as @books" do
      get :index
      assigns(:books).should eq([book])
    end
    
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET show" do
    let(:book) {FactoryGirl.create(:book)}
    before(:each) do
      before_actions_for_user
    end
    
    it "assigns the requested book as @book" do
      get :show, id: book.id
      assigns(:book).should eq(book)
    end
    
    it "renders the show template" do
      get :show, id: book.id
      expect(response).to render_template("show")
    end
  end

  describe "GET new" do
    before(:each) do
      before_actions_for_admin      
    end
    it "assigns a new book as @book" do
      get :new
      assigns(:book).should be_a_new(Book)
    end
  end

  describe "GET edit" do
    let(:book) {FactoryGirl.create(:book)}
    before do
      before_actions_for_admin
    end
    
    it "assigns the requested book as @book" do
      get :edit, id: book.id
      assigns(:book).should eq(book)
    end
  end

  describe "POST create" do
    let(:valid_attributes) {FactoryGirl.attributes_for(:book, author_id: 1).stringify_keys}  
    before(:each) do
      before_actions_for_admin
    end
    
    describe "with valid params" do
      it "creates a new Book" do
        expect {
          post :create, book: valid_attributes
        }.to change(Book, :count).by(1)
      end

      it "assigns a newly created book as @book" do
        post :create, book: valid_attributes
        assigns(:book).should be_a(Book)
        assigns(:book).should be_persisted
      end

      it "redirects to the created book" do
        post :create, book: valid_attributes
        response.should redirect_to(Book.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved book as @book" do
        Book.any_instance.stub(:save).and_return(false)
        post :create, book: invalid_attributes
        assigns(:book).should be_a_new(Book)
      end

      it "re-renders the 'new' template" do
        Book.any_instance.stub(:save).and_return(false)
        post :create, book: invalid_attributes
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    let(:valid_attributes) {FactoryGirl.attributes_for(:book, quantity: "2", pages: "888").stringify_keys}  
    let(:book) {FactoryGirl.create(:book)}
    
    before(:each) do
      before_actions_for_admin
    end
    
    describe "with valid params" do
      it "updates the requested book" do
        Book.any_instance.should_receive(:update).with(valid_attributes)
        put :update, id: book.id, book: valid_attributes
      end

      it "assigns the requested book as @book" do
        put :update, id: book.id, book: valid_attributes
        assigns(:book).should eq(book)
      end

      it "redirects to the book" do
        put :update, id: book.id, book: valid_attributes
        response.should redirect_to(book)
      end
    end

    describe "with invalid params" do
      it "assigns the book as @book" do
        Book.any_instance.stub(:update).and_return(false)
        put :update, id: book.id, book: invalid_attributes
        assigns(:book).should eq(book)
      end

      it "re-renders the 'edit' template" do
        Book.any_instance.stub(:update).and_return(false)
        put :update, id: book.id, book: invalid_attributes
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    let(:book) {FactoryGirl.create(:book)}
    before(:each) do
      before_actions_for_admin
      book.save
    end
    
    it "destroys the requested book" do
      expect {
        delete :destroy, id: book.id
      }.to change(Book, :count).by(-1)
    end

    it "redirects to the books list" do
      delete :destroy, id: book.id
      response.should redirect_to(books_url)
    end
  end
end
