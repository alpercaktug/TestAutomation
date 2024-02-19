# frozen_string_literal: true

class BookingPage
  include PageObject

  button(:date_picker, :xpath => '/html/body/app-root/div/app-search/div/app-search-bar/div/app-datepicker/div/button')
  button(:search, :value => "Search")
  button(:show_rates, :value => "Show Rates")
  button(:add_room, :value => "Add room")
  button(:continue, :value => "Continue")
  div(:unavailable_message, :class => "message-title")
  button(:next_month, :class => "button-next-month")

  def visit_booking_page
    @browser.get BaseUrl + "/bv3/search"
    sleep(1)
  end

  def select_date(checkin_day, checkout_day)
    date_picker

    #@browser.find_element(xpath: "//div[@class='day-item' and text()='#{checkin_day}']").click
    #@browser.find_element(xpath: "//div[@class='day-item' and text()='#{checkout_day}']").click
    #
    @browser.find_element(xpath: "//div[contains(@aria-label, '#{checkin_day}')]").click
    @browser.find_element(xpath: "//div[contains(@aria-label, '#{checkout_day}')]").click
  end

  def click_search_button
    search
    sleep(1)
  end

  def click_show_rates
    show_rates
    sleep(1)
  end

  def click_add_room
    add_room
    sleep(1)
  end

  def click_continue
    continue
    sleep(1)
  end

  def select_room(room_name)
    @browser.find_element(:css, "button[aria-label='Show rates of#{room_name}']").click
  end

  def unavailable_present?()
    unavailable_message.include?("Room unavailable")
  end

  def close
    @browser.close
  end

end
