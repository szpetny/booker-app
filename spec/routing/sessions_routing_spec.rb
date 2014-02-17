require "spec_helper"

describe SessionsController do
  describe "routing" do

    it "routes to #index" do
      get("/sessions").should_not be_routable
    end

    it "routes to #new" do
      get("/sessions/new").should route_to("sessions#new")
    end

    it "routes to #show" do
      get("/sessions/1").should_not be_routable
    end

    it "routes to #edit" do
      get("/sessions/1/edit").should_not be_routable
    end

    it "routes to #create" do
      post("/sessions").should route_to("sessions#create")
    end

    it "routes to #update" do
      put("/sessions/1").should_not be_routable
    end

    it "routes to #destroy" do
      delete("/sessions/1").should route_to("sessions#destroy", :id => "1")
    end

    it "/signin routes to sessions#new" do
      get("/signin").should route_to("sessions#new")
    end
    
    it "/signout routes to sessions#destroy" do
      delete("/signout").should route_to("sessions#destroy")
    end
  end
end
