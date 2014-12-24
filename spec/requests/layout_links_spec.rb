
require 'rails_helper'

RSpec.describe "LayoutLinks", :type => :request do
  describe "GET /layout_links" do
    it "works! (now write some real specs)" do
      get layout_links_index_path
      expect(response).to have_http_status(200)
    end

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
end
