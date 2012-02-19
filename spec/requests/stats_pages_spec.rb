require "rspec"

describe "for signed-in users" do
  let(:user) { FactoryGirl.create(:user) }
  before do
    FactoryGirl.create(:micropost, :user => user, :content => "Lorem")
    FactoryGirl.create(:micropost, :user => user, :content => "Ipsum")
    visit signin_path
    fill_in "Email",    with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"
    visit root_path
  end

  #it "should render the user's feed" do
  #  user.feed.each do |item|
  #    page.should have_selector("tr##{item.id}", content: item.content)
  #  end
  #end

  describe "follower/following counts" do
    let(:other_user) { FactoryGirl.create(:user) }
    before { user.follow!(other_user) }

    #it { should have_selector('a', href: following_user_path(user),
    #                               content: "0 following") }
    #it { should have_selector('a', href: followers_user_path(user),
    #                               content: "1 follower") }
    end

end
