require 'spec_helper'

describe "Micropost pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before do
    visit signin_path
    fill_in "Email",    with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"
  end

  describe "micropost creation" do
    before { visit root_path }

    describe "with invalid information" do

      it "should not create a micropost" do
        expect { click_button "Submit" }.should_not change(Micropost, :count)
      end

      describe "error messages" do
        let(:error) { '1 error prohibited this micropost from being saved' }
        before { click_button "Submit" }
        #it { should have_content(error) }
      end
    end

    describe "with valid information" do

      before { fill_in 'micropost_content', with: "Lorem ipsum" }
      it "should create a micropost" do
        expect { click_button "Submit" }.should change(Micropost, :count).by(1)
      end
    end

  end

  describe "micropost destruction" do
    before { FactoryGirl.create(:micropost, user: user) }

    describe "as correct user" do
      before { visit root_path }

     # it "should delete a micropost" do
     #   expect { click_link "delete" }.should change(Micropost, :count).by(-1)
     # end
    end
  end

end
