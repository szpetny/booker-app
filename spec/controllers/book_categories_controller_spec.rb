require 'spec_helper'

describe BookCategoriesController do

  # This should return the minimal set of attributes required to create a valid
  # BookCategory. As you add validations to BookCategory, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { { "category_name" => "MyString" } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # BookCategoriesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET index" do
    it "assigns all book_categories as @book_categories" do
      book_category = BookCategory.create! valid_attributes
      get :index, {}, valid_session
      assigns(:book_categories).should eq([book_category])
    end
  end

  describe "GET show" do
    it "assigns the requested book_category as @book_category" do
      book_category = BookCategory.create! valid_attributes
      get :show, {:id => book_category.to_param}, valid_session
      assigns(:book_category).should eq(book_category)
    end
  end

  describe "GET new" do
    it "assigns a new book_category as @book_category" do
      get :new, {}, valid_session
      assigns(:book_category).should be_a_new(BookCategory)
    end
  end

  describe "GET edit" do
    it "assigns the requested book_category as @book_category" do
      book_category = BookCategory.create! valid_attributes
      get :edit, {:id => book_category.to_param}, valid_session
      assigns(:book_category).should eq(book_category)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new BookCategory" do
        expect {
          post :create, {:book_category => valid_attributes}, valid_session
        }.to change(BookCategory, :count).by(1)
      end

      it "assigns a newly created book_category as @book_category" do
        post :create, {:book_category => valid_attributes}, valid_session
        assigns(:book_category).should be_a(BookCategory)
        assigns(:book_category).should be_persisted
      end

      it "redirects to the created book_category" do
        post :create, {:book_category => valid_attributes}, valid_session
        response.should redirect_to(BookCategory.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved book_category as @book_category" do
        # Trigger the behavior that occurs when invalid params are submitted
        BookCategory.any_instance.stub(:save).and_return(false)
        post :create, {:book_category => { "category_name" => "invalid value" }}, valid_session
        assigns(:book_category).should be_a_new(BookCategory)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        BookCategory.any_instance.stub(:save).and_return(false)
        post :create, {:book_category => { "category_name" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested book_category" do
        book_category = BookCategory.create! valid_attributes
        # Assuming there are no other book_categories in the database, this
        # specifies that the BookCategory created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        BookCategory.any_instance.should_receive(:update).with({ "category_name" => "MyString" })
        put :update, {:id => book_category.to_param, :book_category => { "category_name" => "MyString" }}, valid_session
      end

      it "assigns the requested book_category as @book_category" do
        book_category = BookCategory.create! valid_attributes
        put :update, {:id => book_category.to_param, :book_category => valid_attributes}, valid_session
        assigns(:book_category).should eq(book_category)
      end

      it "redirects to the book_category" do
        book_category = BookCategory.create! valid_attributes
        put :update, {:id => book_category.to_param, :book_category => valid_attributes}, valid_session
        response.should redirect_to(book_category)
      end
    end

    describe "with invalid params" do
      it "assigns the book_category as @book_category" do
        book_category = BookCategory.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        BookCategory.any_instance.stub(:save).and_return(false)
        put :update, {:id => book_category.to_param, :book_category => { "category_name" => "invalid value" }}, valid_session
        assigns(:book_category).should eq(book_category)
      end

      it "re-renders the 'edit' template" do
        book_category = BookCategory.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        BookCategory.any_instance.stub(:save).and_return(false)
        put :update, {:id => book_category.to_param, :book_category => { "category_name" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested book_category" do
      book_category = BookCategory.create! valid_attributes
      expect {
        delete :destroy, {:id => book_category.to_param}, valid_session
      }.to change(BookCategory, :count).by(-1)
    end

    it "redirects to the book_categories list" do
      book_category = BookCategory.create! valid_attributes
      delete :destroy, {:id => book_category.to_param}, valid_session
      response.should redirect_to(book_categories_url)
    end
  end

end
