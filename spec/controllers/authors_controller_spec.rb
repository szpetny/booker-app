require 'spec_helper'

describe AuthorsController do

  describe "GET index" do
    before(:each) do
      sign_in(FactoryGirl.create(:user))
      controller.stub!(:signed_in_user).and_return(true)
    end
    
    it "assigns filtered authors as @authors" do
      author1 = FactoryGirl.create(:author)
      author2 = FactoryGirl.create(:author)
      params = {:author_search => "Grubson"}
      get :index, params
      assigns(:authors).should eq([author1, author2])
    end
    
    it "assigns all authors as @authors" do
      author = FactoryGirl.create(:author)
      get :index
      assigns(:authors).should eq([author])
    end
    
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET new" do
    before(:each) do
      sign_in(FactoryGirl.create(:admin))
      controller.stub!(:signed_in_user).and_return(true)
      controller.stub!(:admin_user).and_return(true)
    end
    
    it "assigns a new author as @author" do
      get :new
      assigns(:author).should be_a_new(Author)
    end
  end

  describe "GET edit" do
    let(:author) {FactoryGirl.create(:author)}
    before do
      sign_in(FactoryGirl.create(:admin))
      controller.stub!(:signed_in_user).and_return(true)
      controller.stub!(:admin_user).and_return(true)
      author.save
    end
    it "assigns the requested author as @author" do
      get :edit, :id => author.id
      assigns(:author).should eq(author)
    end
  end

  describe "POST create" do
    let(:valid_attributes) do
       { "name" => "Czeslaw", 
         "surname" => "Zdzislaw"} 
    end
    
    let(:invalid_attributes) do
       { "name" => "", 
         "surname" => ""} 
    end
    
    before(:each) do
      sign_in(FactoryGirl.create(:admin))
      controller.stub!(:signed_in_user).and_return(true)
      controller.stub!(:admin_user).and_return(true)
    end
    describe "with valid params" do
      it "creates a new Author" do
        expect {
          post :create, :author => valid_attributes
        }.to change(Author, :count).by(1)
      end

      it "assigns a newly created author as @author" do
        post :create, :author => valid_attributes
        assigns(:author).should be_a(Author)
        assigns(:author).should be_persisted
      end

      it "redirects to the created author when it was normal create" do
        post :create, :author => valid_attributes, :format => 'html'
        flash[:notice].should_not be_nil
        response.should redirect_to(authors_path)
      end
      
      it "return json objects when it was dialog create" do
        post :create, :author => valid_attributes, :format => 'json'
        expect(response.status).to eq(201) 
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved author as @author" do
        Author.any_instance.stub(:save).and_return(false)
        post :create, :author => invalid_attributes
        assigns(:author).should be_a_new(Author)
      end

      it "re-renders the 'new' template" do
        Author.any_instance.stub(:save).and_return(false)
        post :create, :author => invalid_attributes
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    let(:author) {FactoryGirl.create(:author)}
    let(:valid_attributes) do
       { "name" => "Czeslaw", 
         "surname" => "Zdzislaw"} 
    end
    
    let(:invalid_attributes) do
       { "name" => "", 
         "surname" => ""} 
    end
    
    before(:each) do
      sign_in(FactoryGirl.create(:admin))
      controller.stub!(:signed_in_user).and_return(true)
      controller.stub!(:admin_user).and_return(true)
      author.save
    end
    describe "with valid params" do
      it "updates the requested author" do
        Author.any_instance.should_receive(:update).with(valid_attributes)
        put :update, :id => author.id, :author => valid_attributes
      end

      it "assigns the requested author as @author" do
        put :update, :id => author.id, :author => valid_attributes
        assigns(:author).should eq(author)
      end

      it "redirects to the author" do
        put :update, :id => author.id, :author => valid_attributes
        response.should redirect_to(authors_url)
      end
    end

    describe "with invalid params" do
      it "assigns the author as @author" do
        # Trigger the behavior that occurs when invalid params are submitted
        Author.any_instance.stub(:update).and_return(false)
        put :update, :id => author.id, :author => invalid_attributes
        assigns(:author).should eq(author)
      end

      it "re-renders the 'edit' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Author.any_instance.stub(:update).and_return(false)
        put :update, :id => author.id, :author => invalid_attributes
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    let(:author) {FactoryGirl.create(:author)}
    before(:each) do
      sign_in(FactoryGirl.create(:admin))
      controller.stub!(:signed_in_user).and_return(true)
      controller.stub!(:admin_user).and_return(true)
      author.save
    end
    
    it "destroys the requested author" do
      expect {
        delete :destroy, :id => author.id
      }.to change(Author, :count).by(-1)
    end

    it "redirects to the authors list" do
      delete :destroy, :id => author.id
      response.should redirect_to(authors_url)
    end
  end

end
