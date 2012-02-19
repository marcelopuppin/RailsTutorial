Given /^a user visits the sign in page$/ do
  visit signin_path
end

When /^he submits invalid sign in information$/ do
  click_button "Sign in"
end

When /^the user has an account$/ do
  @user = User.create(name: "Example User", email: "user@example.com",
                      password: "foobar", password_confirmation: "foobar")
end

When /^the user submits valid sign in information$/ do
  visit signin_path
  fill_in "Email",    with: @user.email
  fill_in "Password", with: @user.password
  click_button "Sign in"
end

Then /^he should see an error message$/ do
  page.should have_selector('div.flash.error')
end

Then /^he should see his profile page$/ do
  page.should have_selector('title', text: @user.name)
end

Then /^he should see a sign out link$/ do
  page.should have_link('Sign out')
end