require 'spec_helper'

describe BookCategory do
   before {@book_category = FactoryGirl.create(:book_category)}
   
   subject { @book_category }
  
   it {should respond_to(:books)}

   describe "when category_name is not present" do
     before {@book_category.category_name = nil}
     it {should_not be_valid}
   end
end
