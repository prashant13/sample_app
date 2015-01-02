require 'rails_helper'

RSpec.describe Micropost, :type => :model do
  before(:each) do
  	@attr = Factory(:user)
  	@attr = { :content => "value for content" }
  end

  it "should create a new instance given valid attributes" do
  	Micropost.create!(@attr)
  end

  describe "user associations" do
  	before(:each) do
  		@micropost = @user.microposts.create(@attr)
  	end

  	it "should have a user attribute" do
  		@micropost.shoudl respond_to(:user)
  	end

  	it "should have the right title" do
  		@micropost.user_id.should == @user.id
  		@micropost.user.should == @user
  	end
  end

  describe "validations" do
  	it "should require a user id" do
  		Micropost.new(@attr).should_not be_valid
  	end

  	it "should require non blank content" do
  		@user.microposts.build(:content => " ").should_not be_valid
  	end

  	it "should reject long content" do
  		@user.microposts.build(:content => "a" * 141).should_not be_valid
  	end
  end
end
