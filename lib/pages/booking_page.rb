# frozen_string_literal: true

require_relative 'base_page'
require_relative '../utils/helper'

class BookingPage < BasePage
  include PageObject

  # Locators
  button(:date_picker, xpath: '//div[@class="datepicker-container"]/button')
  button(:rooms_and_guests_dropdown, id: 'dropdownMenuButtonOne')
  button(:search_button, xpath: '//div[@class="field field-search"]/button')
  button(:add_room_button, value: 'Add room')
  button(:continue_button, value: 'Continue')

  button(:increase_room_button, xpath: "//div[@class='rate-table']//button[@class='increment']")
  button(:increase_adult_button, xpath: '//div[@class="room-body"]//div[@class="input-row"][1]//button[@class="increment"]')
  button(:decrease_adult_button, xpath: '//div[@class="room-body"]//div[@class="input-row"][1]//button[@class="decrement"]')
  button(:increase_child_button, xpath: '//div[@class="room-body"]//div[@class="input-row"][2]//button[@class="increment"]')
  button(:decrease_child_button, xpath: '//div[@class="room-body"]//div[@class="input-row"][2]//button[@class="decrement"]')

  button(:promotions_button, css: 'div[class^="promo-closed"] button')
  text_field(:promotions_form, name: 'couponCode')
  button(:submit_coupon, id: 'submit-coupon')

  span(:discount_price_label, xpath: '//span[@class="discount-price"]')
  span(:subtotal_price_label, xpath: '//span[@class="sub-total-price"]')
  span(:total_price_label, xpath: '//span[@class="total-price"]')

  div(:invalid_promo_code, xpath: '//div[@class="couponCodeMessage"]')
  div(:want_to_continue, xpath: '//div[@class="modal-content"]')

  def visit_booking_page
    @browser.get "#{BaseUrl}/bv3/search"
    self
  end

  def visit_result
    @browser.get 'https://testautomation.hotelrunner.com/bv3/summary?success=1&o_number=R824072584&o_token=fa3a6a416a6b4913a01436d09acd8dbd'
  end

  def select_date(night_count)
    date_picker

    checkin, checkout = Helper.new.calculate_reservation_date(night_count)

    click(:xpath, "//div[contains(@aria-label, '#{checkin}')]")
    click(:xpath, '/html/body/div[3]/div[1]/div/div[2]/div[1]/button[2]') if night_count > 31
    click(:xpath, "//div[contains(@aria-label, '#{checkout}')]")
    self
  end

  def select_adult(adult)
    # To-do: Check --> Decrease number of adults on Room 1. The present value is 2
    rooms_and_guests_dropdown
    decrease_adult_button if adult == 1

    (1...adult - 1).each do |_i|
      increase_adult_button
    end
    self
  end

  # to-do: Select child

  def click_search_button
    search_button
    self
  end

  def click_add_room_button
    add_room_button
    self
  end

  def click_increase_room_button
    increase_room_button
    self
  end

  def click_show_rates_button(room_name)
    click(:xpath, "//button[@aria-label='Show rates of#{room_name}']")
    self
  end

  def click_hide_rates_button(room_name)
    click(:css, "button[aria-label='Hide rates of#{room_name}']")
    self
  end

  def click_continue_button
    continue_button
  end

  def apply_coupon_code(coupon)
    promotions_button
    self.promotions_form = coupon
    submit_coupon
    self
  end

  def room_count_cart_list(room_name)
    room_elements = @browser.find_elements(:xpath, "//span[@class='item-title' and text()='#{room_name}']")
    puts "There is #{room_elements.count}  #{room_name}  in reservation details"
    room_elements.count
  end

  def guest_info
    get_text(:css, '.guest-info > div:nth-child(3)')
  end

  def available_room_count
    element_count_with_js('//div[@class="search-result-container"]/child::app-room-box[@roomlisttype="available"]/*')
  end

  def available_prices
    get_elements(:xpath, '//app-room-box[@roomlisttype="available"]//div[@class="price"]/div')
  end

  def discount_price
    helper = Helper.new
    subtotal = helper.convert_label_to_price(subtotal_price_label)
    discount = helper.convert_label_to_price(discount_price_label)
    total = helper.convert_label_to_price(total_price_label)

    puts "subtotal = #{subtotal}"
    puts "discount = #{discount}"
    puts "total = #{total}"

    discount_price_label
  end

  def invalid_promo_code_message?
    puts invalid_promo_code
    invalid_promo_code?
  end

  def want_to_continue_message?
    want_to_continue?
  end
end
