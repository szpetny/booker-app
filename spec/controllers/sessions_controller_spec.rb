require 'spec_helper'
require 'pp'

describe SessionsController do
  describe "POST create" do
    let(:user) {FactoryGirl.create(:user)}
    let(:valid_attributes) {
      {"email" => "szmata2@example.com",
      "password" => "xxxxx"}
    }
    
    let(:invalid_attributes) {
      {"email" => "szmata2@example.com",
      "password" => ""}
    }
    
    before(:each) do
      User.stub(:find_by).with(user.email).and_return(user)
    end
    describe "with valid params" do
      it "creates a new Session" do
        user.stub(:authenticate).with("xxx").and_return(true)
        expect {
          post :create, :session => valid_attributes
        }.to receive(:sign_in).with(user)
      end

      it "redirects to the created session" do
        post :create, :session => valid_attributes
        response.should receive(:redirect_back_or_default)
      end
    end

    describe "with invalid params" do
      it "re-renders the 'new' template" do
        post :create, :session => invalid_attributes
        flash[:error].should_not be_nil
        response.should render_template("new")
      end
    end
  end
  
  describe "DELETE destroy" do
    it "destroys the requested session" do
      expect {
        delete :destroy
      }.to receive(:sign_out)
    end

    it "redirects to the sessions list" do
      delete :destroy
      response.should redirect_to(root_url)
    end
  end
end
