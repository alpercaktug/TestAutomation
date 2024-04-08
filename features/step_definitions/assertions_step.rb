# frozen_string_literal: true
#testtest
require_relative '../../lib/pages/booking_page'
require_relative '../../lib/pages/payment_page'
require_relative '../../lib/pages/summary_page'
require_relative '../../lib/pages/extra_page'

Then(/^I should see the reservation is "([^"]*)"$/) do |state|
  result = SummaryPage.new(@browser).result_state
  expect(result).to eq(state), "Expected state #{state}, but is was #{result}"
  puts 'test'
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
  expected = night.to_i == 1 ? "#{night} night" : "#{night} nights"
  puts expected
  expect(BookingPage.new(@browser).guest_info).to eql(expected)
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

Then(/^I should see extras has return successfully$/) do
  expect(ExtraPage.new(@browser).extra?).to eq true
end

Then(/^I should see the extra "([^"]*)" added successfully to cart$/) do |extra_name|
  extra_info = ReservationCart.new(@browser).get_room_extra 'Extras Room', extra_name
  extra_price = ExtraPage.new(@browser).price(extra_name)

  first_item = extra_info[0]
  expect(first_item[:title]).to eq(extra_name), "There is no extra or your extra isn't here."
  actual_total = extra_price + 1000
  puts actual_total

  expect(ReservationCart.new(@browser).total_price).to eq (actual_total)
end


Then(/^I should see recommended room bar is "([^"]*)"$/) do |state|
  actual = BookingPage.new(@browser).recommend_room?
  sleep 5
  if state == 'enable'
    expect(actual).to eq true
  elsif state == 'disable'
    expect(actual).to eq false
  end
end

Then(/^I should see the coupon name is "([^"]*)" on the reservation details$/) do |coupon_name|
  sleep 5
  discount_label = ReservationCart.new(@browser).coupon_code_label
  puts discount_label
  expect(discount_label).to eq(coupon_name), "There is no coupon name or your coupon name isn't here."
end
