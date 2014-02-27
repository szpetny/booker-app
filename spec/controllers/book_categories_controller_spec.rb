require 'spec_helper'
require 'pp' 

describe BookCategoriesController do

  describe "GET index" do
    before(:each) do
      sign_in(FactoryGirl.create(:user))
      controller.stub!(:signed_in_user).and_return(true)
    end
    
    it "assigns all book_categories as @book_categories" do
      book_category = FactoryGirl.create(:book_category)
      get :index
      assigns(:book_categories).should eq([book_category])
    end
    
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  

  describe "DELETE destroy" do
    let(:book_category) {FactoryGirl.create(:book_category)}
    before(:each) do
      sign_in(FactoryGirl.create(:admin))
      controller.stub!(:signed_in_user).and_return(true)
      controller.stub!(:admin_user).and_return(true)
      book_category.save
    end
    
    it "destroys the requested book_category" do
      expect {
        delete :destroy, id: book_category.id
      }.to change(BookCategory, :count).by(-1) 
    end

    it "redirects to the book_categories list" do
      delete :destroy, id: book_category.id, format: 'html'
      response.should redirect_to(book_categories_url)
    end
  end

  describe "POST create" do
    let(:valid_attributes) {FactoryGirl.attributes_for(:book_category)}
    before(:each) do
      sign_in(FactoryGirl.create(:admin))
      controller.stub!(:signed_in_user).and_return(true)
      controller.stub!(:admin_user).and_return(true)
    end
    
    describe "with valid params" do
      it "creates a new BookCategory" do
        expect {
          post :create, book_category: valid_attributes, format: 'json'
        }.to change(BookCategory, :count).by(1)
      end

      it "assigns a newly created book_category as @book_category" do
        post :create, book_category: valid_attributes, format: 'json'
        assigns(:book_category).should be_a(BookCategory)
        assigns(:book_category).should be_persisted
      end

      it "redirects to the created book_category" do
        post :create, book_category: valid_attributes, format: 'json'
      end
      
      it "return json objects when it was dialog create" do
        post :create, book_category: valid_attributes, format: 'json'
        expect(response.status).to eq(201) 
      end
    end
  end
end 

