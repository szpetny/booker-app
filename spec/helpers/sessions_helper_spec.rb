require 'spec_helper'

describe SessionsHelper do

  describe "sign_in(user)" do
    let(:user) {FactoryGirl.create(:user)}
    it "signs in the user to the application" do
      sign_in user
      current_user?(user).should eq(true)
    end
  end
  
  describe "signed_in?" do
    let(:user) {FactoryGirl.create(:user)}
    before {sign_in(user)}
    it "checks if user is signed in" do
      expect(current_user.nil?).to be_false
    end 
  end
  
  describe "current_user=(user)" do
    let(:user) {FactoryGirl.create(:user)}
    before {sign_in(user)}
    it "checks if user is set" do
      current_user=(user)
      current_user?(user).should eq(true)
    end 
  end
  
  describe "current_user" do
    let(:user) {FactoryGirl.create(:user)}
    before do
        User.stub!(:find_by).and_return(user)
    end
    it "checks if user is set" do
      expect(current_user).to eq(user)
    end 
  end

  describe "current_user?(user)" do
    let(:user1) {FactoryGirl.create(:user)}
    let(:user2) {FactoryGirl.create(:admin)}
    it "is true that current user and user are eq" do
      sign_in user1
      current_user.should ==(user1)
    end
    it "is false that current user and user are eq" do
      sign_in user1
      current_user.should_not ==(user2)
    end
  end
  
  describe "sign_out" do
    let(:user) {FactoryGirl.create(:user)}
    before {sign_in user}
    it "signs in the user to the application" do
      sign_out
      current_user?(user).should eq(false)
    end
  end

end
