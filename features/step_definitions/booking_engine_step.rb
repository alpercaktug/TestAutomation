# frozen_string_literal: true

require_relative '../../lib/pages/booking_page'
require_relative '../../lib/pages/payment_page'
require_relative '../../lib/pages/result_page'
require 'date'


Given(/^I navigate to booking page$/) do
  booking_page = BookingPage.new(@browser)
  booking_page.visit_booking_page
end

When(/^I make a reservation to "([^"]*)" for (\d+) night$/) do |room_name, night|
  booking_page = BookingPage.new(@browser)
  booking_page.click_date_picker
  booking_page.select_date(night)
  booking_page.click_search_button
  booking_page.click_show_rates_button(room_name)
  booking_page.click_add_room_button
  booking_page.click_continue_button
end

When(/^Fill payment page fields$/) do
 payment_page = PaymentPage.new(@browser)
 payment_page.fill_contact_information
 payment_page.click_complete
end

When(/^Verify reservation is "([^"]*)"$/) do |result|
  result_page = ResultPage.new(@browser)
  expect(result_page.state_present?(result)).to eql(true)
end

When(/^Cancel reservation on result page$/) do
  result_page = ResultPage.new(@browser)
  result_page.click_cancel
  result_page.click_yes
end

When(/^I select check\-in and check\-out day for (\d+) night$/) do |night|
  booking_page = BookingPage.new(@browser)
  booking_page.click_date_picker
  booking_page.select_date(night)
  booking_page.click_search_button
end

Then(/^I should see correct (\d+) information on reservation detail$/) do |night|
  booking_page = BookingPage.new(@browser)
  expected = night.to_i == 1 ? "#{night} night" : "#{night} nights"
  puts expected
  expect(booking_page.guest_info).to eql(expected)
end

When(/^I don't fill (.*)$/) do |field|
  payment_page = PaymentPage.new(@browser)
  payment_page.fill_contact_information_without(field)
  payment_page.click_complete
end

Then(/^I should see (.*) under (.*)$/) do |error_message, field|
  payment_page = PaymentPage.new(@browser)
  expect(payment_page.error_message(field)).to eql error_message
end

# ------

Given(/^"([^"]*)" is unavailable for today$/) do |room_name|
  booking_page = BookingPage.new(@browser)
  booking_page.visit_booking_page
  booking_page.click_show_rates_button(room_name)
  booking_page.click_add_room_button
  booking_page.click_continue_button
  payment_page = PaymentPage.new(@browser)
  payment_page.fill_contact_information
  payment_page.click_complete
end

When(/^I try to make a reservation to "([^"]*)" for today$/) do |_arg|
  booking_page = BookingPage.new(@browser)
  booking_page.visit_booking_page
  booking_page.click_search_button
end

Then(/^I should see room is unavailable$/) do
  booking_page = BookingPage.new(@browser)
  expect(booking_page.unavailable_present?).to eql true
end

When(/^I add (\d+) "([^"]*)" for (\d+) night$/) do |room_count, room_name, _night|
  booking_page = BookingPage.new(@browser)
  booking_page.click_show_rates_button(room_name)
  booking_page.click_add_room_button
  (2..room_count).each do |_i|
    booking_page.click_increase_room_button
  end
  booking_page.click_hide_rates_button(room_name)
end

Then(/^I should see (\d+) "([^"]*)" has added on reservation details$/) do |room_count, room_name|
  booking_page = BookingPage.new(@browser)
  expect(booking_page.room_count_cart_list(room_name)).to eql room_count
end

When(/^I complete reservation$/) do
  booking_page = BookingPage.new(@browser)
  booking_page.click_continue_button
  booking_page.click_continue_with_different_room_search
  payment_page = PaymentPage.new(@browser)
  payment_page.fill_contact_information
  payment_page.click_complete
end

When(/^I search for (\d+) rooms, (\d+) adults, (\d+) night$/) do |_arg1, _arg2, night|
  booking_page = BookingPage.new(@browser)
  booking_page.click_date_picker
  booking_page.select_date(night)
  booking_page.set_rooms_and_guests
end

When(/^I click search button$/) do
  booking_page = BookingPage.new(@browser)
  booking_page.click_search_button
end


Given(/^Test new$/) do
  booking_page = BookingPage.new(@browser)
  sleep 4
  booking_page.visit_booking_page
  sleep 4
  expect(booking_page.search_appear?).to eql true
end

