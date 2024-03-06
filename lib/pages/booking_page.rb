# frozen_string_literal: true

require_relative 'base_page'
require_relative '../utils/helper'

class BookingPage < BasePage
  include PageObject

  # Locators
  button(:date_picker, xpath: '/html/body/app-root/div/app-search/div/app-search-bar/div/app-datepicker/div/button')
  button(:search_button, value: 'Search')
  button(:add_room_button, value: 'Add room')
  button(:continue_button, value: 'Continue')
  button(:room_increase_button, xpath: "//button[@class='increment']")
  button(:rooms_and_guests_dropdown, id: 'dropdownMenuButtonOne')
  link(:add_room_link, class: 'more-room')



  # Do you have the right number of rooms?
  button(:continue_with_different_room_search, class: 'prmry')
  div(:available_room_count, xpath: "count(//div[@class='search-result-container']/child::app-room-box[@roomlisttype='available']/*)")
  #button(:show_rates, value: 'Show Rates')
  div(:unavailable_message, class: 'message-title')
  button(:next_month, class: 'button-next-month')


  def visit_booking_page
    @browser.get "#{BaseUrl}/bv3/search"
  end

  def click_date_picker
    date_picker
  end

  def select_date(night_count)
    checkin, checkout = Helper.new.calculate_reservation_date(night_count)

    click(:xpath, "//div[contains(@aria-label, '#{checkin}')]")
    click(:xpath, '/html/body/div[3]/div[1]/div/div[2]/div[1]/button[2]') if night_count > 31
    click(:xpath, "//div[contains(@aria-label, '#{checkout}')]")
    self
  end

  def click_search_button
    search_button
  end

  def click_add_room_button
    add_room_button
  end

  def click_continue_button
    continue_button
  end

  def click_show_rates_button(room_name)
    click(:css, "button[aria-label='Show rates of#{room_name}']")
  end

  def click_hide_rates_button(room_name)
    click(:css, "button[aria-label='Hide rates of#{room_name}']")
  end

  def room_count_cart_list(room_name)
    room_elements = @browser.find_elements(:xpath, "//span[@class='item-title' and text()='#{room_name}']")
    puts "There is #{room_elements.count}  #{room_name}  in reservation details"
    room_elements.count
  end

  def click_increase_room_button
    room_increase_button
  end


  def unavailable_present?
    unavailable_message.include?('Room unavailable')
  end

  def guest_info
    get_text(:css, '.guest-info > div:nth-child(3)')
  end


  def set_rooms_and_guests
    rooms_and_guests_dropdown
    add_room_link
  end

  def click_continue_with_different_room_search
    continue_with_different_room_search
  end

  def get_available_room_count
    sleep 5
    element_count_with_js('//div[@class="search-result-container"]/child::app-room-box[@roomlisttype="unavailable"]/*')
  end
end
