require 'spec_helper'

RSpec.describe PagesController, :type => :controller do
  render_views

  before(:each) do
    @base_title = "Ruby on Rails Tutorial Sample App"
  end

  describe "GET home" do

    describe "when not signed in" do

      before(:each) do
        get :home
      end

      it "should be successful" do
        expect(response).to be_success
      end

      it "should have the right title" do
        expect(response).to have_selector("title", 
                                          :content => "#{@base_title} | Home")
      end
    end

    describe "when signed in" do

      before(:each) do
        @user = test_sign-in(Factory(:user))
        other_user = Factory(:user, :email => Factory.next(:email))
        other_user.follow!(@user)
      end

      it "should have the right follower/following counts" do
        get :home
        expect(response).to have_selector("a", :href => following_user_path(@user),
                                               :content => "0 following")
        expect(response).to have_selector("a", :href => followers_user_path(@user),
                                               :content => "1 follower")
      end
    end
    it "returns http success" do
      get 'home'
      expect(response).to have_http_status(:success)
    end

    it "should have the right title" do
      get 'home'
      expect(response).to have_selector("title",
                        :content => @base_title +" | Home")
    end
  end

  describe "GET contact" do
    it "returns http success" do
      get 'contact'
      expect(response).to have_http_status(:success)
    end

    it "should have the right title" do
      get 'home'
      expect(response).to have_selector("title",
                        :content => @base_title +" | Contact")
    end
  end

  describe "GET about" do
    it "returns http success" do
      get 'about'
      expect(response).to have_http_status(:success)
    end

    it "should have the right title" do
      get 'home'
      expect(response).to have_selector("title",
                        :content => @base_title +" | About")
    end
  end

end
