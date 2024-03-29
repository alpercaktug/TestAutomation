# frozen_string_literal: true

require_relative '../../lib/pages/login_page'

require 'show_me_the_cookies'

When(/^Navigate to login page$/) do
  @login_page = LoginPage.new(@browser)
  @login_page.visit_login_page
end

When(/^Fill user credentials$/) do
  @login_page.fill_credentials
end

When(/^Click login button$/) do
  @login_page.click_login_button
  sleep 15


end

When(/^Verify login is successful$/) do
  pending
end

When(/^Navigate to logout$/) do
  @login_page.logout
end

And(/^Quit browser$/) do
  @browser.quit
end

