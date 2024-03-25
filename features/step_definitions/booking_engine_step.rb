# frozen_string_literal: true

require_relative '../../lib/pages/booking_page'
require_relative '../../lib/pages/payment_page'
require_relative '../../lib/pages/summary_page'
require_relative '../../lib/pages/sections/reservation_details'

# NAVIGATE TO BOOKING PAGE
# done
Given(/^Navigate to the booking page$/) do
  BookingPage.new(@browser).visit_booking_page
  sleep 4
end

# GET DATA FROM TABLE
# done
Given(/^I have the following data$/) do |table|
  # table is a table.hashes.keys # => [:Night, :Adult Count, :Child Count, :Room Type, :Payment Method]
  @data = table.hashes

  @data.each do |row|
    @night = row['Night'].to_i
    @adult = row['Adult Count'].to_i
    @child = row['Child Count'].to_i
    @room = row['Room Type']
    @payment = row['Payment Method']

    puts row
  end
end

# MAKE COMPLETE RESERVATION WITH DATA TABLE
# done
When(/^Make a reservation with the data$/) do
  BookingPage.new(@browser)
             .visit_booking_page
             .select_date(@night.to_i)
             .select_adult(@adult.to_i)
             .click_search_button
             .click_show_rates_button(@room)
             .click_add_room_button
             .click_continue_button
  PaymentPage.new(@browser).fill_contact_information
             .select_payment_method(@payment)
             .click_complete
end

# MAKE COMPLETE RESERVATION WITH PARAMETERS
# done
When(/^Make a reservation for a "([^"]*)" for (\d+) night and (\d+) adult with "([^"]*)"$/) do |room_type, night, adult, payment_method|
  BookingPage.new(@browser)
             .visit_booking_page
             .select_date(night)
             .select_adult(adult)
             .click_search_button
             .click_show_rates_button(room_type)
             .click_add_room_button
             .click_continue_button
  PaymentPage.new(@browser).fill_contact_information
             .select_payment_method(payment_method)
             .click_complete
end

# SELECT ADULT
# done
When(/^Search for an available room for (\d+) adult$/) do |adult|
  BookingPage.new(@browser)
             .select_adult(adult)
             .click_search_button
end

# SELECT CHECKIN-CHECKOUT
# done
When(/^Search for an available room for (\d+) night$/) do |night|
  BookingPage.new(@browser)
             .select_date(night)
             .click_search_button
end

# ADD ROOM
# done
When(/^Add (\d+) "([^"]*)" to the cart$/) do |amount, room_type|
  booking_page = BookingPage.new(@browser)
                            .click_show_rates_button(room_type)
                            .click_add_room_button

  (2..amount).each do |_i|
    booking_page.click_increase_room_button
  end

  booking_page.click_hide_rates_button(room_type)
end

# CONTINUE
# wip (not just payment page)
And(/^Continue to the payment page$/) do
  BookingPage.new(@browser)
             .click_continue_button
end

# done
When(/Fill contact form$/) do
  PaymentPage.new(@browser).fill_contact_information
end

# CANCEL
# done
When(/^Cancel reservation on result page$/) do
  SummaryPage.new(@browser)
             .click_cancel
             .click_yes
end

# SPECIAL
# done
When(/^Make a reservation to "([^"]*)" for (\d+) night without filling "([^"]*)" on payment page$/) do |room_name, night, field|
  BookingPage.new(@browser)
             .select_date(night)
             .click_search_button
             .click_show_rates_button(room_name)
             .click_add_room_button
             .click_continue_button
  PaymentPage.new(@browser).fill_contact_information_without(field)
             .click_complete
end

# SETTINGS (NEW)
# wip
Given(/^that the "([^"]*)" setting is "([^"]*)"$/) do |setting, ability|
  pending
end

# PAYMENT (MAIL ORDER)
# done
And(/^Complete the reservation with mail order$/) do |table|
  # table is a table.hashes.keys # => [:Number, :CVC, :Expire, :Firstname, :Lastname]
  @data = table.hashes

  @data.each do |row|
    @number = row['Number']
    @cvc = row['CVC']
    @expire = row['Expire']
    @firstname = row['Firstname']
    @lastname = row['Lastname']

    puts row
  end
  PaymentPage.new(@browser)
             .select_payment_method('Mail Order')
             .fill_card_form(@number, @cvc, @expire, @firstname, @lastname)
             .click_complete
end

# PAYMENT (BANK TRANSFER)
# done
When(/^Complete the reservation with bank transfer$/) do
  PaymentPage.new(@browser)
             .select_payment_method('Bank Transfer')
             .click_complete
end

# PAYMENT (PAY AT THE PROPERTY)
And(/^Complete the reservation with pay at the property$/) do
  PaymentPage.new(@browser)
             .select_payment_method('Cash')
             .click_complete
end

# APPLY COUPON CODE
# done
And(/^Apply a coupon code that "([^"]*)"$/) do |code|
  BookingPage.new(@browser).apply_coupon_code code
  sleep 4
end

When(/^I add "([^"]*)" to the cart$/) do |arg|
  pending
end