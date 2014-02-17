require "spec_helper"

describe AuthorsController do
  describe "routing" do

    it "routes to #index" do
      get("/authors").should route_to("authors#index")
    end

    it "routes to #index with :author_search param" do
      get('/authors?author_search=devil').should route_to('authors#index', :author_search => "devil")
    end
    
    it "routes /author_books/:author_id" do
      get('/author_books/1').should route_to('books#index', :author_id => "1")
    end

    it "routes to #new" do
      get("/authors/new").should route_to("authors#new")
    end

    it "routes to #show" do
      get("/authors/1").should_not be_routable
    end

    it "routes to #edit" do
      get("/authors/1/edit").should route_to("authors#edit", :id => "1")
    end

    it "routes to #create" do
      post("/authors").should route_to("authors#create")
    end

    it "routes to #update" do
      put("/authors/1").should route_to("authors#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/authors/1").should route_to("authors#destroy", :id => "1")
    end

  end
end
