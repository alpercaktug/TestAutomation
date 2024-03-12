# frozen_string_literal: true
require_relative '../../lib/pages/booking_page'
require_relative '../../lib/pages/payment_page'
require_relative '../../lib/pages/result_page'

#done
Given(/^I navigate to the booking page$/) do
  BookingPage.new(@browser).visit_booking_page
end

#done
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

#done
When(/^I make a reservation with the data$/) do
  BookingPage.new(@browser)
             .visit_booking_page
             .select_date(@night.to_i)
             .select_adult(@adult.to_i)
             .click_search_button
             .click_show_rates_button(@room)
             .click_add_room_button
             .click_continue_button
             .fill_contact_information
             .select_payment_method(@payment)
             .click_complete
end


When(/^I make a reservation for a "([^"]*)" for (\d+) night and (\d+) adult with "([^"]*)"$/) do |room_type, night, adult, payment_method|
  BookingPage.new(@browser)
             .visit_booking_page
             .select_date(night)
             .select_adult(adult)
             .click_search_button
             .click_show_rates_button(room_type)
             .click_add_room_button
             .click_continue_button
             .fill_contact_information
             .select_payment_method(payment_method)
             .click_complete
end



#done
When(/^I search for an available room for (\d+) night and (\d+) adult$/) do |night, guest|
  BookingPage.new(@browser)
             .select_date(night)
             .select_adult(guest)
             .click_search_button
end

#done
When(/^I add (\d+) "([^"]*)" to the cart$/) do |amount, room_type|

  booking_page = BookingPage.new(@browser)
                            .click_show_rates_button(room_type)
                            .click_add_room_button

  (2..amount).each do |_i|
    booking_page.click_increase_room_button
  end

  booking_page.click_hide_rates_button(room_type)
end

#done
And(/^I continue to the payment page$/) do
  BookingPage.new(@browser)
             .click_continue_button
end

#done
When(/^I fill contact form$/) do
  PaymentPage.new(@browser).fill_contact_information
end

#done
When(/^Cancel reservation on result page$/) do
  ResultPage.new(@browser)
            .click_cancel
            .click_yes
end

#done
When(/^I make a reservation to "([^"]*)" for (\d+) night without filling "([^"]*)" on payment page$/) do |room_name, night, field|
  BookingPage.new(@browser)
             .select_date(night)
             .click_search_button
             .click_show_rates_button(room_name)
             .click_add_room_button
             .click_continue_button
             .fill_contact_information_without(field)
             .click_complete
end


Given(/^that the "([^"]*)" setting is "([^"]*)"$/) do |setting, ability|
  puts "#{setting} is #{ability}"
end


#done
And(/^I complete the reservation with mail order$/) do |table|
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
             .select_payment_method('Mail order')
             .fill_card_form(@number, @cvc, @expire, @firstname, @lastname )
             .click_complete
end

#done
When(/^I complete the reservation with bank transfer$/) do
  PaymentPage.new(@browser)
             .select_payment_method('Bank Transfer')
             .click_complete
end

