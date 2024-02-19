
require_relative '../pages/booking_page'
require_relative '../pages/payment_page'

Given(/^Make a reservation$/) do | table |
  @data = table.hashes
  data_table = @data[0]
  @booking_page = BookingPage.new(@browser)
  @booking_page.visit_booking_page
  @booking_page.select_date(data_table['Checkin'],data_table['Checkout'])
  @booking_page.click_search_button
  #@booking_page.click_show_rates
  sleep(5)
  @booking_page.select_room("Classic Room")
  sleep(5)
  @booking_page.click_add_room
  @booking_page.click_continue
end

When(/^Fill payment page fields$/) do
  @payment_page = PaymentPage.new(@browser)
  @payment_page.fill_contact_information
  @payment_page.click_complete
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
  @booking_page.select_room(room_name)
  @booking_page.click_add_room
  @booking_page.click_continue
end

When(/^Navigate to booking page and verify room is unavailable$/) do
  @booking_page = BookingPage.new(@browser)
  sleep(3)
  @booking_page.visit_booking_page
  sleep(3)
  expect(@booking_page.unavailable_present?).to eql true
  sleep(3)
end



Given(/^"([^"]*)" is unavailable for today$/) do |room_name|
  @booking_page = BookingPage.new(@browser)
  @booking_page.visit_booking_page
  @booking_page.select_room(room_name)
  @booking_page.click_add_room
  @booking_page.click_continue
  @payment_page = PaymentPage.new(@browser)
  @payment_page.fill_contact_information
  @payment_page.click_complete
end


When(/^I try to make a reservation to "([^"]*)" for today$/) do |arg|
  @booking_page = BookingPage.new(@browser)
  sleep(3)
  @booking_page.visit_booking_page
  @booking_page.click_search_button
end


Then(/^I should see room is unavailable$/) do
  expect(@booking_page.unavailable_present?).to eql true
  sleep(3)
end

