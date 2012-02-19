require 'spec_helper'

describe "AuthenticationPages" do

  subject { response }

  describe "signin page" do
    before { visit signin_path }

    it "should have a Sign in text" do
      should have_selector('h1', content: 'Sign in')
    end
    it "should have a Sign in title" do
      should have_selector('title', content: 'Sign in')
    end
  end

  describe "signin" do
    before { visit signin_path }

    describe "with invalid information" do
      before { click_button "Sign in" }

      it "should have a Sign in title" do
        should have_selector('title', content: 'Sign in')
      end

      it "should have an invalid error" do
        should have_selector('div.flash.error', content: 'Invalid')
      end

      describe "after visiting another page" do
        before { click_link "Home" }
        it "should not have a message error" do
          should_not have_selector('div.flash.error')
        end
      end

    end
  end

#  describe "with valid information" do
#    let(:user) { FactoryGirl.create(:user) }
#    before do
#      visit signin_path
#      fill_in "Email", user.email
#      fill_in "Password", user.password
#      click_button "Sign in"
#    end
#
#    it { should have_selector('title', content: user.name) }
#    it { should have_link('Users',    href: users_path) }
#    it { should have_link('Profile',  href: user_path(user)) }
#    it { should have_link('Settings', href: edit_user_path(user)) }
#    it { should have_link('Sign out', href: signout_path) }
#    it { should_not have_link('Sign in', href: signin_path) }
#  end


  describe "authorization" do
    describe "for non-signed-in users" do
      let(:user) { Factory(:user) }

      describe "visiting user index" do
        before { visit users_path }
        it { should have_selector('title', content: 'Sign in') }
      end

      describe "in the Users controller" do

        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_selector('title', content: 'Sign in') }
        end

        describe "submitting to the update action" do
          before { put user_path(user) }
          specify { response.should redirect_to(signin_path) }
        end
      end

      describe "when attempting to visit a protected page" do
        before do
          visit edit_user_path(user)
          fill_in "Email",    with: user.email
          fill_in "Password", with: user.password
          click_button "Sign in"
        end

        describe "after signing in" do
          it "should render the desired protected page" do
            should have_selector('title', content: 'Edit user')
          end
        end
      end

      describe "in the Microposts controller" do

        describe "submitting to the create action" do
          before { post microposts_path }
          specify { response.should redirect_to(signin_path) }
        end

        describe "submitting to the destroy action" do
          before do
            micropost = FactoryGirl.create(:micropost)
            delete micropost_path(micropost)
          end
          specify { response.should redirect_to(signin_path) }
        end

      end

    end

    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
      before do
        visit signin_path
        fill_in "Email",    with: user.email
        fill_in "Password", with: user.password
        click_button "Sign in"
      end

      describe "visiting Users#edit page" do
        before { visit edit_user_path(wrong_user) }
        it { should have_selector('title', content: 'Sample App') }
      end

      describe "submitting a PUT request to the Users#update action" do
        before { put user_path(wrong_user) }
        specify { response.should redirect_to(root_path) }
      end
    end
  end

end
