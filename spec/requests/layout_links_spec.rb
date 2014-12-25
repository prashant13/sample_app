

require 'spec_helper'

RSpec.describe "LayoutLinks" do
  
  describe "GET /layout_links" do
    it "should have a Home page at '/'" do
    	get '/'
    	expect(response).to have_selector('title', :text => "Home")
    end

    it "should have a Contact page at '/contact'" do
    	get '/contact'
    	expect(response).to have_selector('title', :text => "Contact")
    end

    it "should have a About page at '/about'" do
    	get '/about'
    	expect(response).to have_selector('title', :text => "About")
    end

    it "should have a Help page at '/help'" do
    	get '/help'
    	expect(response).to have_selector('title', :text => "Help")
    end

    it "should have a signup page at /signup" do
        get '/signup'
        expect(response).to have_selector("title", :text => "Sign up")
    end
    

  end

  describe "when not signed in" do
    it "should have a signin link" do
        visit root_path
        expect(response).to have_selector("a", :href => signin_path,
                                                :content => "Sign in")
    end
  end

  describe "when signed in" do

    before(:each) do
        @user = Factory(:user)
        visti signin_path
        fill_in :email, :with => @user.email
        fill_in :password, :with => @user.password
        click_button
    end

    it "should have a signout link" do
        visit root_path
        expect(response).to have_selector("a", :href => signout_path,
                                               :content => "Sign out")
    end

    it "should have a profile link" do
        visit root_path
        expect(response).to have_selector("a", :href => user_path(@user),
                                               :content => "Profile")
    end
  end

end
