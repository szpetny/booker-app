require 'spec_helper'
require 'pp'

describe Author do

 before do
    @author = Author.new(name: "Michail", surname: "Bulhakow")
  end

  subject { @author }

  it { should respond_to(:name) }
  it { should respond_to(:surname) }
  it { should respond_to(:books) }
  
  describe "when name is not present" do
    before{@author.name = nil}
    it {should_not be_valid}
  end
  
  describe "when name is too long" do
    before{@author.name = "imie12345678901234567890123456789012345678901234567890"}
    it {should_not be_valid}
  end
  
  describe "when surname is not present" do
    before{@author.surname = nil}
    it {should_not be_valid}
  end
  
  describe "when surname is too long" do
    before{@author.surname = "imie12345678901234567890123456789012345678901234567890"}
    it {should_not be_valid}
  end
  
  describe "name_and_surname" do
    it {expect(@author.name_and_surname).to eq("Michail Bulhakow")}
  end
  
  describe "surname_and_name" do
     it {expect(@author.surname_and_name).to eq("Bulhakow Michail")}
  end
end