# frozen_string_literal: true

#wip
class ReservationCart < BasePage
  include PageObject

  div(:cart_container, class: 'cart-container')

  # Methods to interact with elements inside the cart container
  def cart_title
    cart_container_element.h2_element(class: 'cart-title').text
  end

  def check_in_date
    cart_container_element.div_element(class: 'dates-info').div_elements[0].text.strip
  end

  def check_out_date
    cart_container_element.div_element(class: 'dates-info').div_elements[1].text.strip
  end

  def room_info
    cart_container_element.div_element(class: 'guest-info').text.strip
  end

  def subtotal_price
    price_label = cart_container_element.span_element(class: 'sub-total-price').text.strip
    Helper.new.convert_label_to_price(price_label)
  end

  def total_price
    price_label = cart_container_element.span_element(class: 'total-price').text.strip
    Helper.new.convert_label_to_price(price_label)
  end

  def discount_price
    price_label = cart_container_element.span_element(class: 'discount-price').text.strip
    Helper.new.convert_label_to_price(price_label)
  end

  # Method to interact with room elements with room type
  def get_room_info(room_name)
    room_divs = cart_container_element.divs(class: 'room')
    room_info = []

    room_divs.each do |room_div|
      item_title_span = room_div.span(class: 'item-title')
      if item_title_span.exists? && item_title_span.text.strip == room_name
        room_type = room_div.span(class: 'item-title').text.strip
        rate_plan = room_div.span(class: 'rate-plan').text.strip
        count = room_div.span(class: 'count').text.strip
        price = room_div.span(class: 'price').text.strip
        room_info << { room_type: room_type, rate_plan: rate_plan, count: count, price: price }
      end
    end
    room_info
  end

  def get_room_info_all
    room_divs = cart_container_element.divs(class: 'room')
    room_info = []

    room_divs.each do |room_div|
      room_type = room_div.span(class: 'item-title').text.strip
      rate_plan = room_div.span(class: 'rate-plan').text.strip
      count = room_div.span(class: 'count').text.strip
      price = room_div.span(class: 'price').text.strip
      room_info << { room_type: room_type, rate_plan: rate_plan, count: count, price: price }
    end
    room_info
  end

  def get_room_extra(room_name, extra_name)
    room_divs = cart_container_element.divs(class: 'room')
    extra_info = []

    room_divs.each do |room_div|
      item_title_span = room_div.span(class: 'item-title')
      if item_title_span.exists? && item_title_span.text.strip == room_name
        extras_divs = room_div.divs(class: 'extras')
        extras_divs.each do |extra_div|
          extra_title_span = extra_div.span(class: 'item-title')
          if extra_title_span.exist? && extra_title_span.text.strip == extra_name
            title = extra_div.span(class: 'item-title').text.strip
            count = extra_div.span(class: 'count').text.strip
            price = extra_div.span(class: 'price').text.strip
            extra_info << { title: title, count: count, price: price }
          end
        end
      end
    end
    extra_info
  end
end
