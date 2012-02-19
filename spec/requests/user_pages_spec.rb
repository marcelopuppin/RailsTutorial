require 'spec_helper'

describe "User pages" do

  subject { response }

  describe "signup" do

    before { visit signup_path }

    it { should have_selector('h1',    content: 'Sign up') }
    it { should have_selector('title', content: 'Sign up') }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button "Sign up" }.not_to change(User, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "Name",         with: "Example User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button "Sign up" }.to change(User, :count).by(1)
      end

    end
  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      visit signin_path
      fill_in "Email",    with: user.email
      fill_in "Password", with: user.password
      click_button "Sign in"
      visit edit_user_path(user)
    end

    describe "page" do
      it { should have_selector('h1',    content: "Edit user") }
      it { should have_selector('title', content: "Edit user") }
      #it { should have_link('change', href: "www.gravatar.com/emails") }
    end

    describe "with invalid information" do
      let(:error) { '1 error prohibited this user from being saved' }
      before do
        click_button "Update"
      end

      #it { should have_content(error) }
    end

    describe "with valid information" do
       let(:user)      { FactoryGirl.create(:user) }
       let(:new_name)  { "New Name" }
       let(:new_email) { "new@example.com" }
       before do
         fill_in "Name",         with: new_name
         fill_in "Email",        with: new_email
         fill_in "Password",     with: user.password
         fill_in "Confirmation", with: user.password
         click_button "Update"
       end

       it { should have_selector('title', content: new_name) }
       it { should have_selector('div.flash.success') }
       specify { user.reload.name.should  == new_name }
       specify { user.reload.email.should == new_email }
    end

  end

  describe "index" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      visit signin_path
      fill_in "Email",    with: user.email
      fill_in "Password", with: user.password
      click_button "Sign in"

      FactoryGirl.create(:user, name: "Bob", email: "bob@example.com")
      FactoryGirl.create(:user, name: "Ben", email: "ben@example.com")
      visit users_path
    end

    it { should have_selector('title', content: 'All users') }

    #it "should list each user" do
    #  User.all.each do |user|
    #    page.should have_selector('li', content: user.name)
    #  end
    #end
  end

  #describe "user" do
  #  it { should respond_to(:admin) }
  #  it { should respond_to(:authenticate) }
  #
  #  it { should be_valid }
  #  it { should_not be_admin }
  #
  #  describe "with admin attribute set to 'true'" do
  #    before { @user.toggle!(:admin) }
  #    it { should be_admin }
  #  end
  #end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:m1) { FactoryGirl.create(:micropost, user: user, content: "Foo") }
    let!(:m2) { FactoryGirl.create(:micropost, user: user, content: "Bar") }

    before do
      visit signin_path
      fill_in "Email",    with: user.email
      fill_in "Password", with: user.password
      click_button "Sign in"
      visit user_path(user)
    end

    it { should have_selector('h1',    content: user.name) }
    it { should have_selector('title', content: user.name) }

    #describe "microposts" do
    #  it { should have_content(m1.content) }
    #  it { should have_content(m2.content) }
    #  it { should have_content(user.microposts.count) }
    #end
  end
end



