require_relative '../pages/booking_page'
require_relative '../pages/payment_page'
require 'date'

Given(/^Make a reservation$/) do | table |
  @data = table.hashes
  data_table = @data[0]
  @booking_page = BookingPage.new(@browser)
  @booking_page.visit_booking_page
  @booking_page.select_date(data_table['Checkin'],data_table['Checkout'], 0)
  @booking_page.click_search_button
  #@booking_page.click_show_rates
  sleep(2)
  @booking_page.select_room("Classic Room")
  sleep(2)
  @booking_page.click_add_room
  @booking_page.click_continue
end

When(/^Verify reservation is "([^"]*)"$/) do |result|
  @result_page = ResultPage.new(@browser)
  expect(@result_page.state_present?(result)).to eql(true)
end

When(/^Cancel reservation on result page$/) do
  @result_page.click_cancel
  @result_page.click_yes
end

When(/^Make a reservation to "([^"]*)"$/) do |room_name|
  @booking_page = BookingPage.new(@browser)
  @booking_page.visit_booking_page
  sleep(3)
  @booking_page.select_room(room_name)
  sleep(3)
  @booking_page.click_add_room
  @booking_page.click_continue
end

When(/^Navigate to booking page and verify room is unavailable$/) do
  @booking_page = BookingPage.new(@browser)
  @booking_page.visit_booking_page
  expect(@booking_page.unavailable_present?).to eql true
end

Given(/^"([^"]*)" is unavailable for today$/) do |room_name|
  @booking_page = BookingPage.new(@browser)
  @booking_page.visit_booking_page
  sleep(2)
  @booking_page.select_room(room_name)
  sleep(2)
  @booking_page.click_add_room
  @booking_page.click_continue
  @payment_page = PaymentPage.new(@browser)
  @payment_page.fill_contact_information
  @payment_page.click_complete
end

When(/^I try to make a reservation to "([^"]*)" for today$/) do |arg|
  @booking_page = BookingPage.new(@browser)
  @booking_page.visit_booking_page
  @booking_page.click_search_button
end

Then(/^I should see room is unavailable$/) do
  expect(@booking_page.unavailable_present?).to eql true
end

Given(/^I navigate to booking page$/) do
  @booking_page = BookingPage.new(@browser)
  @booking_page.visit_booking_page
end

When(/^I select check\-in and check\-out day for (\d+) night$/) do |night|

  checkin = Date.today
  checkout = checkin + night

  interval = (checkout - checkin).to_i

  checkin = checkin.strftime("%B %d")
  checkout = checkout.strftime("%B %d")

  puts checkin
  puts checkout

  @booking_page.select_date(checkin,checkout, interval)
  @booking_page.click_search_button

end

Then(/^I should see correct (\d+) information on reservation detail$/) do |night|
  expected = night.to_i == 1 ? "#{night} night" : "#{night} nights"
  puts expected
  expect(@booking_page.guest_info).to eql(expected)
end
