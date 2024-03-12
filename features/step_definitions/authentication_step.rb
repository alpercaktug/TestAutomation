# frozen_string_literal: true

require_relative '../../lib/pages/login_page'


When(/^Navigate to login page$/) do
  @login_page = LoginPage.new(@browser)
  @login_page.visit_login_page
end

When(/^Fill user credentials$/) do
  @login_page.fill_credentials
end

When(/^Click login button$/) do
  @login_page.click_login_button
end

When(/^Verify login is successful$/) do
  pending
end

When(/^Navigate to logout$/) do
  @login_page.logout
end

