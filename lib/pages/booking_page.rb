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

  button(:increase_adult_button, xpath: '//div[@class="room-body"]//div[@class="input-row"][1]//button[@class="increment"]')
  button(:decrease_adult_button, xpath: '//div[@class="room-body"]//div[@class="input-row"][1]//button[@class="decrement"]')

  button(:increase_child_button, xpath: '//div[@class="room-body"]//div[@class="input-row"][2]//button[@class="increment"]')
  button(:decrease_child_button, xpath: '//div[@class="room-body"]//div[@class="input-row"][2]//button[@class="decrement"]')

  link(:add_room_link, class: 'more-room')
  div(:price, xpath: '//div[@class="search-result-container"]/child::app-room-box[@roomlisttype="available"]//div[@class="price"]//div')

  def visit_booking_page
    @browser.get "#{BaseUrl}/bv3/search"
    self
  end

  def click_date_picker
    date_picker
    self
  end

  def select_date(night_count)
    click_date_picker

    checkin, checkout = Helper.new.calculate_reservation_date(night_count)

    click(:xpath, "//div[contains(@aria-label, '#{checkin}')]")
    click(:xpath, '/html/body/div[3]/div[1]/div/div[2]/div[1]/button[2]') if night_count > 31
    click(:xpath, "//div[contains(@aria-label, '#{checkout}')]")
    self
  end

  def select_adult(adult)
    # To-do: Check --> Decrease number of adults on Room 1. The present value is 2
    click_rooms_and_guests
    decrease_adult if adult == 1

    (1...adult-1).each do |_i|
      increase_adult
    end
    self
  end
  # to-to: Select child

  def click_search_button
    search_button
    self
  end

  def click_add_room_button
    add_room_button
    self
  end

  def click_continue_button
    continue_button
    PaymentPage.new(@browser)
  end

  def click_show_rates_button(room_name)
    click(:xpath, "//button[@aria-label='Show rates of#{room_name}']")
    self
  end

  def click_hide_rates_button(room_name)
    click(:css, "button[aria-label='Hide rates of#{room_name}']")
    self
  end

  def room_count_cart_list(room_name)
    room_elements = @browser.find_elements(:xpath, "//span[@class='item-title' and text()='#{room_name}']")
    puts "There is #{room_elements.count}  #{room_name}  in reservation details"
    room_elements.count
  end

  def click_increase_room_button
    room_increase_button
    self
  end

  def guest_info
    get_text(:css, '.guest-info > div:nth-child(3)')
  end

  def increase_adult
    increase_adult_button
  end

  def decrease_adult
    decrease_adult_button
  end

  def click_rooms_and_guests
    rooms_and_guests_dropdown
    self
  end

  def get_available_room_count
    element_count_with_js('//div[@class="search-result-container"]/child::app-room-box[@roomlisttype="available"]/*')
  end

  def available_prices
    get_elements(:xpath, '//app-room-box[@roomlisttype="available"]//div[@class="price"]/div')
  end
end
