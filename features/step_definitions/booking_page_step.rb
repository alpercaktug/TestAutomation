
require_relative '../pages/booking_page'
require_relative '../pages/payment_page'

Given(/^Make a reservation$/) do
  @booking_page = BookingPage.new(@browser)
  @booking_page.visit_booking_page
  #to-do
  #@booking_page.click_date_picker
  #@booking_page.select_date
  @booking_page.click_search_button
  @booking_page.click_show_rates
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