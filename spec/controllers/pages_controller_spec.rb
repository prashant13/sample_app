require 'spec_helper'

RSpec.describe PagesController, :type => :controller do
  render_views

  before(:each) do
    @base_title = "Ruby on Rails Tutorial Sample App"
  end

  describe "GET home" do
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
