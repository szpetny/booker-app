require 'spec_helper'
require 'pp'

describe UsersController do
  let(:correct_admin_user) {FactoryGirl.create(:admin)}
  
  def before_actions_for_admin 
    sign_in(correct_admin_user)
    controller.stub!(:admin_user).and_return(true)
    controller.stub!(:correct_user).and_return(true)
  end  
  
  describe "GET index" do
    before(:each) do
      sign_in(correct_admin_user)
      controller.stub!(:admin_user).and_return(true)
    end
    
    it "assigns all users as @users" do
      get :index
      assigns(:users).should eq([correct_admin_user])
    end
    
    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "GET show" do
    before(:each) do
      before_actions_for_admin
    end
    
    it "assigns the requested user as @user" do
      get :show, id: correct_admin_user.id
      assigns(:user).should eq(correct_admin_user)
    end
    
    it "renders the show template" do
      get :show, id: correct_admin_user.id
      expect(response).to render_template("show")
    end
  end

  describe "GET new" do
    before(:each) do
      before_actions_for_admin
    end
    
    it "assigns a new user as @user" do
      get :new
      assigns(:user).should be_a_new(User)
    end
  end

  describe "GET edit" do
    before do
      before_actions_for_admin
    end
    
    it "renders the edit template" do
      get :edit, id: correct_admin_user.id
      expect(response).to render_template("edit")
    end
  end

  describe "POST create" do
    let(:valid_attributes) {FactoryGirl.attributes_for(:user).stringify_keys} 
    let(:invalid_attributes) {FactoryGirl.attributes_for(:user, password_confirmation: "gghhjj").stringify_keys} 
    
    before(:each) do
      before_actions_for_admin
    end
    describe "with valid params" do
      it "creates a new User" do
        expect {
          post :create, user: valid_attributes
        }.to change(User, :count).by(1)
      end

      it "assigns a newly created user as @user" do
        post :create, user: valid_attributes
        assigns(:user).should be_a(User)
        assigns(:user).should be_persisted
      end

      it "redirects to the created user" do
        post :create, user: valid_attributes
        response.should redirect_to(User.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved user as @user" do
        User.any_instance.stub(:save).and_return(false)
        post :create, user: invalid_attributes
        assigns(:user).should be_a_new(User)
      end

      it "re-renders the 'new' template" do
        User.any_instance.stub(:save).and_return(false)
        post :create, user: invalid_attributes
        response.should render_template("new")
      end
    end
  end
  
  describe "DELETE destroy" do
    let(:user) {FactoryGirl.create(:user)}
    before(:each) do
      before_actions_for_admin
      user.save
    end
    
    it "destroys the requested user" do
      expect {
        delete :destroy, id: user.id
      }.to change(User, :count).by(-1)
    end

    it "redirects to the users list" do
      delete :destroy, id: user.id
      response.should redirect_to(users_url)
    end
  end
  
  describe "PUT update" do
    let(:valid_attributes) {FactoryGirl.attributes_for(:user).stringify_keys} 
    let(:invalid_attributes) {FactoryGirl.attributes_for(:user, password_confirmation: "gghhjj").stringify_keys} 
    
    before(:each) do
      before_actions_for_admin
    end
    
    describe "with valid params" do
      it "updates the requested user and redirects to profile view" do
        user = User.create! valid_attributes
        user.stub!(:update).with(valid_attributes).and_return(true)
        put :update, id: user.to_param, user: valid_attributes
        response.should redirect_to(user)
      end

      it "update of the requested user fails and returns to edit" do
        user = User.create! valid_attributes
        user.stub!(:update).with(invalid_attributes).and_return(false)
        put :update, id: user.to_param, user: invalid_attributes
        response.should render_template("edit")
      end
    end
  end   
end
