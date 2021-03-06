require 'spec_helper'

RSpec.describe UserController, :type => :controller do

  render_views

  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "should have the right title" do
    	get :new
    	expect(response).to have_selector("title", :content => "Sign up")
    end
  end

  describe "POST 'create'" do
    describe "failure" do
      before(:each) do
        @attr = { :name => "", :email => "", :password => "",
                  :password_confirmation => "" }
      end

      it "should not create a user" do
        lambda do
          post :create, :user => @attr
        end.should_not change(User, :count)
      end

      it "should have the right title" do
        post :create, :user => @attr
        expect(response).to have_selector("title", :content => "Sign up")
      end

      it "should render the 'new' page" do
        post :create, :user => @attr
        expect(response).to render_template('new')
      end
    end

    describe "success" do

      before(:each) do
        @attr = { :name => "New User", :email => "user@example.com",
                  :password => "foobar", :password_confirmation => "foobar" }
      end

      it "should create a user" do
        lambda do
          post :create, :user => @attr
        end.should change(User, :count).by(1)
      end

      it "should redirect to the user show page" do
        post :create. :user => @attr
        expect(response).to redirect_to(user_path(assigns(:user)))
      end

      it "should have a welcome message" do
        post :create, :user => @attr
        flash[:success].to =~ /welcome to the sample app/i
      end

      it "should sign the user in" do
        post :create, :user => @attr
        controller.should be_signed_in
      end
    end

  describe "GET edit" do

    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
    end

    it "should be successful" do
      get :edit, :id => @user
      expect(response).to have_selector("title", :content => "Edit user")
    end

    it "should have a link to change the Gravatar" do
      get :edit, :id => @user
      gravatar_url = "http://gravatr.com/emails"
      expect(response).to have_selector("a", :href => gravatar_url,
                                             :content => "change")
   end
  end

  describe "PUT update" do

    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
    end

    describe "failure" do

      before(:each) do
        @attr = { :eamil => "", :name => "", :password => "",
                  :password_confirmation => "" }
      end

      it "should render the edit page" do
        put :update, :id => @user, :user => @attr
        expect(response).to render_template('edit')
      end

      it "should have the right title" do
        put :update, :id => @user, :user => @attr
        expect(response).to have_selector("title", :content => "Edit user")
      end
    end

    describe "success" do

       before(:each) do
        @attr => { :name => "New Name", :email => "user@example.org",
                   :password => "barbaz", :password_confirmation => "barbaz" }
      end

      it "should change the user's attributes" do
        put :update, :id => @user, :user => @attr
        @user.reload
        @user.name.should == @attr[:name]
        @user.email.should == @attr[:email]
      end

      it "should redirect to the user show page" do
        put :update, :id => @user, :user => @attr
        expect(response).to redirect_to(user_path(@user))
      end

      it "should have a flash message" do
        put :update, :id => @user, :user => @attr
        flash[:success].to =~ /updated/
      end
    end
  end

  describe "authentication of edit/update pages" do

    before(:each) do
      @user = Factory(:user)
    end

    describe "for non-signed-in users" do

      it "should deny access to 'edit'" do
        get :edit, :id => @user
        expect(response).to redirect_to(signin_path)
      end

      it "should deny access to 'update'" do
        put :uupdate, :id => @user, :user => {}
        expect(response).to redirect_to(signin_path)
      end
    end

    describe "for signed-in users" do

      before(:each) do
        wrong_user = Factory(:user, :email => "user@example.net")
        test_sign_in(wrong_user)
      end

      it "should require matching users for 'edit'" do
        get :edit, :id => @user
        expect(response).to redirect_to(root_path)
      end

      it "should require matching users for 'update'" do
        get :update, :id => @user, :user => {}
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "follow pages" do

    describe "when not signed in" do

      it "should protect 'following'" do
        get :following, :id => 1
        expect(response).to redirect_to(signin_path)
      end

      it "should protect 'followers'" do
        get :followers,:id => 1
        expect(response).to redirect_to(signin_path)
      end  
    end

    describe "when signed in" do

      before(:each) do
        @user = test_sign_in(Factory(:user))
        @other_user = Factory(:user, :email => Factory.next(:email))
        @user.follow!(@other_user)
      end

      it "should show user following" do
        get :following, :id => @user
        expect(response).to have_selector("a", :href => user_path(@other_user),
                                               :content => @other_user.name)
      end

      it "should show user followers" do
        get :followers, :id => @other_user
        expect(response).to have_selector("a", :href => user_path(@user),
                                               :content => @user.name)
      end
    end
  end
end
