require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
	render_views

	describe "GET 'index'" do

		describe "for non-signed-in users" do

			it "should deny access" do
				get :index
				expect(response).to redirect_to(signin_path)
				flash[:notice].should =~ /sign in/i		
			end
		end

		describe "for signed-in users" do

			before(:each) do
				@user = test_sign_in(Factory(:user))
				second = Factory(:user. :name => "Bob", :email => "another@example.com")
				third = Factory(:user, :name => "Ben", :email => "another@example.net")

				@user = [@user, second, third]
			end

			it "should be successful" do
				get :index
				expect(response).to be_success
			end

			it "should have the right title" do
				get :index
				expect(response).to have_selector("title", :content => "All users")
			end

			it "should have an element for eacj=h user" do
				get :index
				@user.each do |user|
					expect(response).to have_selector("li", :content => user.name)
				end
			end
		end
	end

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

		it "should show the user's microposts" do
			mp1 = Factory(:micropost, :user => @user, :content => "Foo bar")
			mp2 = Factory(:micropost, :user => @user, :content => "Baz quux")
			get :show, :id => @user
			expect(response).to have_selector("span.content", :content => mp1.content)
			expect(response).to have_selector("span.content", :content => mp2.content)
		end

		it "should show the user's microposts" do
			mp1 = Factory(:micropost, :user => @user, :content => "Foo bar")
			mp2 = Factory(:micropost, :user => @user, :content => "Baz quux")
			get :show, :id => @user
			expect(response).to have_selector("span.content", :content => mp1.content)
			expect(response).to have_selector("span.content", :content => mp2.content)
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

  	describe "DELETE 'destroy'" do
  		before(:each) do
  			@user = Factory(:user)
  		end

  		describe "as a non-signed-in user" do
  			it "should deny access" do
  				delete :destroy, :id => @user
  				expect(response).to redirect_to(root_path)
  			end
  		end

  		describe "as a non-admin user" do
  			it "should protect the page" do
  				test_sign_in(@user)
  				delete :destroy, :id => @user
  				expect(response).to redirect_to(root_path)
  			end
  		end

  		describe "as an admin user" do
  			before(:each) do
  				admin = Factory(:user, :email => "admin@example.com", :admin => true)
  				test_sign_in(admin)
  			end

  			it "should destroy the user" do
  				lambda do
  					delete :destroy, :id => @user
  				end.should change(User, :count).by(-1)
  			end

  			it "should redirect to the users page" do
  				delete :destroy, :id => @user
  				expect(response).to redirect_to(users_path)
  			end
  		end
  	end

end
