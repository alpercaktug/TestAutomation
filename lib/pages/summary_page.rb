# frozen_string_literal: true

class SummaryPage < BasePage
  include PageObject

  link(:cancel, class: 'cancellation-btn')
  button(:yes, class: 'prmry')
  div(:result, xpath: '//div[contains(@class, "success")]')

  div(:reservation_number, class: 'reservation-number')
  div(:result_state, class: 'state')
  div(:room_item, class: 'room-item')

  span(:subtotal_price, class: 'sub-total-price')
  span(:discount_price, xpath: '//div[@class = "item"][2]//span[@class="sub-total-price"]')
  span(:total_price, class: 'total-price')

  divs(:room_divs, class: 'room-item')

  main(:room_items)

  def summary_url
    puts @browser.current_url
  end

  def reservation_number
    reservation_number_element.text.strip
  end

  def result_state
    puts result_state_element.text
    result_state_element.text
  end

  def subtotal_price
    subtotal_price_element.text.strip
  end

  def discount_price
    discount_price_element.text.strip
  end

  def total_price
    total_price_element.text.strip
  end

  def click_cancel
    cancel
    self
  end

  def click_yes
    yes
    sleep 3
  end
end
