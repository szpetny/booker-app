require 'spec_helper'

describe BooksController do
  describe "GET index" do
    before(:each) do
      sign_in(FactoryGirl.create(:user))
      controller.stub!(:signed_in_user).and_return(true)
    end
    
    it "assigns author's books as @books" do
      author = FactoryGirl.build(:author)
      book = FactoryGirl.create(:book)
      author.books << book
      author.save
      params = {author_id: author.id}
      get :index, params
      assigns(:books).should eq([book])
    end
    
    it "assigns all books as @books" do
      book = FactoryGirl.create(:book)
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
      sign_in(FactoryGirl.create(:user))
      controller.stub!(:signed_in_user).and_return(true)
      book.save
    end
    
    it "assigns the requested book as @book" do
      get :show, :id => book.id
      assigns(:book).should eq(book)
    end
    
    it "renders the show template" do
      get :show, :id => book.id
      expect(response).to render_template("show")
    end
  end

  describe "GET new" do
    before(:each) do
      sign_in(FactoryGirl.create(:admin))
      controller.stub!(:signed_in_user).and_return(true)
      controller.stub!(:admin_user).and_return(true)
    end
    it "assigns a new book as @book" do
      get :new
      assigns(:book).should be_a_new(Book)
    end
  end

  describe "GET edit" do
    let(:book) {FactoryGirl.create(:book)}
    before do
      sign_in(FactoryGirl.create(:admin))
      controller.stub!(:signed_in_user).and_return(true)
      controller.stub!(:admin_user).and_return(true)
      book.save
    end
    it "assigns the requested book as @book" do
      get :edit, :id => book.id
      assigns(:book).should eq(book)
    end
  end

  describe "POST create" do
    let(:valid_attributes) do
       { "isbn" => "83-07-0234204", 
         "title" => "Leszcz i Malgorzata", 
         "author_id" => 1, 
         "language" => "ruslanski", 
         "description" => "costam costam", 
         "photo" => "gdziestam/costam.png", 
         "quantity" => 1, 
         "place" => "srodek jamnika", 
         "release_date" => "1982-03-31", 
         "pages" => 777 } 
    end
    
    let(:invalid_attributes) do
       { "isbn" => "nie nie nie", 
         "language" => "ruslanski", 
         "description" => "costam costam", 
         "quantity" => "tu tu", 
         "release_date" => "1982-03-31", 
         "pages" => "foo" } 
    end
    
    before(:each) do
      sign_in(FactoryGirl.create(:admin))
      controller.stub!(:signed_in_user).and_return(true)
      controller.stub!(:admin_user).and_return(true)
    end
    describe "with valid params" do
      it "creates a new Book" do
        expect {
          post :create, :book => valid_attributes
        }.to change(Book, :count).by(1)
      end

      it "assigns a newly created book as @book" do
        post :create, :book => valid_attributes
        assigns(:book).should be_a(Book)
        assigns(:book).should be_persisted
      end

      it "redirects to the created book" do
        post :create, :book => valid_attributes
        response.should redirect_to(Book.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved book as @book" do
        # Trigger the behavior that occurs when invalid params are submitted
        Book.any_instance.stub(:save).and_return(false)
        post :create, :book => invalid_attributes
        assigns(:book).should be_a_new(Book)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Book.any_instance.stub(:save).and_return(false)
        post :create, :book => invalid_attributes
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    let(:book) {FactoryGirl.create(:book)}
    let(:valid_attributes) do
       { "isbn" => "1234-7890", 
         "title" => "Sledziu i Malgorzata", 
         "author_id" => "2", 
         "language" => "wegierski", 
         "description" => "costam costam", 
         "photo" => "gdziestam/costam.png", 
         "quantity" => "2", 
         "place" => "srodek setera", 
         "release_date" => "1981-03-11", 
         "pages" => "767" } 
    end
    
    let(:invalid_attributes) do
       { "isbn" => "nie nie nie", 
         "language" => "ruslanski", 
         "description" => "costam costam", 
         "quantity" => "tu tu", 
         "release_date" => "1982-03-31", 
         "pages" => "foo" } 
    end
    
    before(:each) do
      sign_in(FactoryGirl.create(:admin))
      controller.stub!(:signed_in_user).and_return(true)
      controller.stub!(:admin_user).and_return(true)
      book.save
    end
    describe "with valid params" do
      it "updates the requested book" do
        Book.any_instance.should_receive(:update).with(valid_attributes)
        put :update, :id => book.id, :book => valid_attributes
      end

      it "assigns the requested book as @book" do
        put :update, :id => book.id, :book => valid_attributes
        assigns(:book).should eq(book)
      end

      it "redirects to the book" do
        put :update, :id => book.id, :book => valid_attributes
        response.should redirect_to(book)
      end
    end

    describe "with invalid params" do
      it "assigns the book as @book" do
        # Trigger the behavior that occurs when invalid params are submitted
        Book.any_instance.stub(:update).and_return(false)
        put :update, :id => book.id, :book => invalid_attributes
        assigns(:book).should eq(book)
      end

      it "re-renders the 'edit' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Book.any_instance.stub(:update).and_return(false)
        put :update, :id => book.id, :book => invalid_attributes
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    let(:book) {FactoryGirl.create(:book)}
    before(:each) do
      sign_in(FactoryGirl.create(:admin))
      controller.stub!(:signed_in_user).and_return(true)
      controller.stub!(:admin_user).and_return(true)
      book.save
    end
    
    it "destroys the requested book" do
      expect {
        delete :destroy, :id => book.id
      }.to change(Book, :count).by(-1)
    end

    it "redirects to the books list" do
      delete :destroy, :id => book.id
      response.should redirect_to(books_url)
    end
  end

end
