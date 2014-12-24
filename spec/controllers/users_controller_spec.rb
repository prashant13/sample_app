require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
	render_views

	describe "GET 'show'" do

		before(:each) do
			@user = Factory(:user)
		end

		it "should be successful" do
			get :show, :id => @user
			response.should be_success
		end

		it "should find the right user" do
			get :show, :id => @user
			assigns(:user).should == @user
		end

		it "should have the right title" do
			get :show, :id => @user
			expect(response).to have_selector("title", :content => @user.name)
		end

		it "should include the user's name" do
			get :show, :id => @user
			expect(response).to have_selector("h1", :content => @user.name)
		end

		it "should have a profile image" do
			get :show, :id => @user
			expect(response).to have_selector("h1>img", :class => "gravatar")
		end

	end

  	describe "GET 'new'" do
    	it "returns http success" do
      		get :new
      		expect(response).to have_http_status(:success)
    	end

    	it "should have the right title" do
    		get 'new'
    		expec(response).to have_selector("title", :content => "Sign up")
    	end
  	end

end
