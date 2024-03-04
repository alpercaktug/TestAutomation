# frozen_string_literal: true
require_relative 'base_page'

class BookingPage < BasePage
  include PageObject

  button(:date_picker, :xpath => '/html/body/app-root/div/app-search/div/app-search-bar/div/app-datepicker/div/button')
  button(:search, :value => "Search")
  button(:show_rates, :value => "Show Rates")
  button(:add_room, :value => "Add room")
  button(:continue, :value => "Continue")
  div(:unavailable_message, :class => "message-title")
  button(:next_month, :class => "button-next-month")
  text_field(:guest_info, :xpath => "//div[@class='guest-info']")
  div(:room_cart_list, :xpath => "//div[@class='cart-list']/div[1]")
  button(:room_increment, :xpath=> "//button[@class='increment']")
  button(:rooms_and_guests_dropdown, :id => "dropdownMenuButtonOne")
  link(:add_room_link, class: 'more-room')

  # Do you have the right number of rooms?
  button(:continue_with_different_room_search, class: 'prmry')

  def visit_booking_page
    @browser.get BaseUrl + "/bv3/search"
  end

  def click_date_picker
    date_picker
  end

  def select_date(night_count)

    checkin_day = Date.today
    checkout_day = checkin_day + night_count

    checkin_day = checkin_day.strftime("%B %-e")
    checkout_day = checkout_day.strftime("%B %-e")

    puts checkin_day
    puts checkout_day

    click(:xpath, "//div[contains(@aria-label, '#{checkin_day}')]")
    if night_count > 31
      click(:xpath, "/html/body/div[3]/div[1]/div/div[2]/div[1]/button[2]")
    end
    click(:xpath, "//div[contains(@aria-label, '#{checkout_day}')]")
  end

  def click_search
    search
  end

  def click_add_room
    add_room
  end

  def click_continue
    continue
  end

  def click_show_rates(room_name)
    click(:css, "button[aria-label='Show rates of#{room_name}']")
  end

  def click_hide_rates(room_name)
    click(:css ,"button[aria-label='Hide rates of#{room_name}']")
  end

  def unavailable_present?
    unavailable_message.include?("Room unavailable")
  end

  def guest_info
    get_text(:css, '.guest-info > div:nth-child(3)')
  end

  def room_exist_cart_list(room_name)
    room_elements = @browser.find_elements(:xpath, "//span[@class='item-title' and text()='#{room_name}']")
    puts "There is #{room_elements.count}  #{room_name}  in reservation details"
    room_elements.count
  end

  def click_room_increment
    room_increment
  end

  def close
    @browser.close
  end

  def set_rooms_and_guests
    rooms_and_guests_dropdown
    add_room_link
  end

  def click_continue_with_different_room_search
    continue_with_different_room_search
  end

end
