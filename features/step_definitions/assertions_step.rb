require_relative '../../lib/pages/booking_page'
require_relative '../../lib/pages/payment_page'
require_relative '../../lib/pages/result_page'


Then(/^Verify reservation is "([^"]*)"$/) do |result|
  result_page = ResultPage.new(@browser)
  expect(result_page.state_present?(result)).to eql(true)
end


Then(/^I should see the reservation is "([^"]*)"$/) do |state|
  actual = ResultPage.new(@browser).result
  expect(actual).to eql state
end


Then(/^I should see a list of available rooms$/) do
  room_count = BookingPage.new(@browser).get_available_room_count
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
  booking_page = BookingPage.new(@browser)
  expect(booking_page.room_count_cart_list(room_name)).to eql room_count
end


Then(/^I should see (.*) under (.*)$/) do |error_message, field|
  payment_page = PaymentPage.new(@browser)
  expect(payment_page.error_message).to eql error_message
end


Then(/^I should see invalid card number message$/) do
  expect(PaymentPage.new(@browser).invalid_card?).to eq true
end
