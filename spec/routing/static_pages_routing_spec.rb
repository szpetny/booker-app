require "spec_helper"

describe BookCategoriesController do
  describe "routing" do
    it "/help routes to static_pages#help" do
      get("/help").should route_to("static_pages#help")
    end
  end
end
