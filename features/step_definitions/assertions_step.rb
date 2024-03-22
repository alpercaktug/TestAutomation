# frozen_string_literal: true

require_relative '../../lib/pages/booking_page'
require_relative '../../lib/pages/payment_page'
require_relative '../../lib/pages/summary_page'
require_relative '../../lib/pages/extra_page'

Then(/^I should see the reservation is "([^"]*)"$/) do |state|
  sleep 15
  result = SummaryPage.new(@browser).result_state
  expect(result).to eql state
end

Then(/^I should see a list of available rooms$/) do
  room_count = BookingPage.new(@browser).available_room_count
  puts "Available room count =  #{room_count}"
  expect(room_count).to be_positive, "Expected room count to be positive, but it was #{room_count}"
end

Then(/^the prices for each room should be displayed$/) do
  prices = BookingPage.new(@browser).available_prices
  prices.each_with_index do |element, index|
    expect(element.text).to_not be_nil, "Price at index #{index} is null"
    puts "Price #{index} : #{element.text}"
  end
end

Then(/^I should see correct (\d+) information on reservation detail$/) do |night|
  booking_page = BookingPage.new(@browser)
  expected = night.to_i == 1 ? "#{night} night" : "#{night} nights"
  puts expected
  expect(booking_page.guest_info).to eql(expected)
end

Then(/^I should see the total price for the reservation$/) do
  pending
end

Then(/^I should see (\d+) "([^"]*)" has added on reservation details$/) do |room_count, room_name|
  expect(BookingPage.new(@browser).room_count_cart_list(room_name)).to eql room_count
end

Then(/^I should see (.*) under (.*)$/) do |error_message, field|
  expect(PaymentPage.new(@browser).error_message).to eql error_message
end

Then(/^I should see invalid card number message$/) do
  expect(PaymentPage.new(@browser).invalid_card?).to eq true
end

Then(/^I should see that the coupon discount is successful in reservation detail$/) do
  expect(BookingPage.new(@browser).discount_price).to eql '-₺100.00'
end

Then(/^I should see the invalid promo code message$/) do
  expect(BookingPage.new(@browser).invalid_promo_code_message?).to eq true
end

Then(/^I should see do you want to continue dialog$/) do
  expect(BookingPage.new(@browser).want_to_continue_message?).to eq true
end

Then(/^I should see extras$/) do
  expect(ExtraPage.new(@browser).extra?).to eq true
end
