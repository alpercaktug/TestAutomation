# frozen_string_literal: true

class ExtraPage < BasePage
  include PageObject

  button(:show_extra, xpath: '//h5[text()="Airport Transfer"]/..//button[@name="button"]')
  button(:add_to_room, xpath: '//div[@class="extra-room"]//button')
  div(:extra_container, xpath: '//div[@class="extra-container"]')

  div(:extra_price, xpath: '//div[@class="extra"]//span[@class="price"]')

  def click_show_extra
    show_extra
  end

  def add_to_room
    add_to_room
  end

  def extra?
    wait_until(5, 'Extras not found on page') do
      extra_container?
    end
    extra_container?
  end

  def extra_price_text
    pending
  end
end
