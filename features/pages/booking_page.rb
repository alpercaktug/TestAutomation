# frozen_string_literal: true

class BookingPage
  include PageObject

  button(:date_picker, :xpath => '/html/body/app-root/div/app-search/div/app-search-bar/div/app-datepicker/div/button')
  button(:search, :value => "Search")
  button(:show_rates, :value => "Show Rates")
  button(:add_room, :value => "Add room")
  button(:continue, :value => "Continue")
  #button(:checkin_date, :xpath => "//div[@class='day-item' and text()='#{checkin_day}']")
  #button(:checkout_date, :xpath => "//div[@class='day-item' and text()='#{checkout_day}']")

  def visit_booking_page
    @browser.get 'https://alperctest123.hotelrunner.com/bv3/search'
  end

  def click_date_picker
    date_picker
  end

  def select_date
    checkin_date
    checkout_date
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

  def close
    @browser.close
  end

end
