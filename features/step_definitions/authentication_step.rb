require_relative '../pages/login_page'

When(/^Navigate to login page$/) do
  @login_page = LoginPage.new(@browser)
  @login_page.visit_login_page
  sleep(2)
end

When(/^Fill user credentials$/) do
  @login_page.fill_credentials
  sleep(2)
end

When(/^Click login button$/) do
  @login_page.click_login_button
  sleep(3)
end

When(/^Verify login is successful$/) do
  pending
end

When(/^Navigate to logout$/) do
  @login_page.logout
end