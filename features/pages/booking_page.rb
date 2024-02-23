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
  text_field(:guest_info, :xpath => "//div[@class='guest-info']")

  def visit_booking_page
    @browser.get BaseUrl + "/bv3/search"
  end

  def select_date(checkin_day, checkout_day, interval)
    date_picker

    @browser.find_element(xpath: "//div[contains(@aria-label, '#{checkin_day}')]").click
    if interval>31
      @browser.find_element(xpath: "/html/body/div[3]/div[1]/div/div[2]/div[1]/button[2]").click
    end
    @browser.find_element(xpath: "//div[contains(@aria-label, '#{checkout_day}')]").click
  end

  def click_search_button
    search
  end

  def click_show_rates
    show_rates
  end

  def click_add_room
    add_room
  end

  def click_continue
    continue
  end

  def select_room(room_name)
    @browser.find_element(:css, "button[aria-label='Show rates of#{room_name}']").click
  end

  def unavailable_present?
    unavailable_message.include?("Room unavailable")
  end

  def guest_info
    @browser.find_element(:css, '.guest-info > div:nth-child(3)').text
  end

  def close
    @browser.close
  end

end
