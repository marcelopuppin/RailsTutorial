require "spec_helper"
require "rspec"

describe PagesController do
  render_views

  before(:each) do
    @basetitle = "Ruby on Rails Tutorial Sample Application"
  end

  describe "GET 'home'" do
    it "should be successful" do
      get 'home'
      response.should be_success
    end

    it "should have a right title" do
      get 'home'
      response.should have_selector("title", :content => @basetitle + " | Home")
    end
  end

  describe "GET 'contact'" do
      it "should be successful" do
        get 'contact'
        response.should be_success
      end
    end

  describe "GET 'about'" do
    it "should be successful" do
      get 'about'
      response.should be_success
    end
  end

  describe "GET 'help'" do
    it "should be successful" do
      get 'help'
      response.should be_success
    end

    it "should have a right title" do
      get 'help'
      response.should have_selector("title", :content => @basetitle + " | Help")
    end
  end

end

