require 'spec_helper'
require 'pp'

describe SessionsController do
  describe "POST create" do
    let(:user) {FactoryGirl.create(:user)}
    let(:valid_attributes) {{session: {email: "szmata1@example.com", password: "siersciuch"}}}
    let(:invalid_attributes) {{session: {email: "szmata1@example.com", password: ""}}}
    
    before(:each) do
      email = controller.stub!(:downcase_email).and_return("szmata1@example.com")
      User.stub!(:find_by).and_return(user)
    end
    describe "with valid params" do
      it "redirects to the created session" do
        user.stub!(:authenticate).and_return(true)
        post :create, session: valid_attributes
        response.should redirect_to(root_url)
      end
    end

    describe "with invalid params" do
      it "re-renders the 'new' template" do
        post :create, session: invalid_attributes
        flash[:error].should_not be_nil
        response.should render_template("new")
      end
    end
  end
  
  describe "DELETE destroy" do
    let(:user) {FactoryGirl.create(:user)}
    before(:each) do
      email = controller.stub!(:downcase_email).and_return("szmata1@example.com")
      User.stub!(:find_by).and_return(user)
      user.stub!(:authenticate).and_return(true)
    end

    it "redirects to the sessions list" do
      delete :destroy
      response.should redirect_to(root_url)
    end
  end
end
