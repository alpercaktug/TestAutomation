# frozen_string_literal: true

class Helper
  def calculate_reservation_date(night_count)
    checkin_day = Date.today
    checkout_day = checkin_day + night_count

    checkin_day = checkin_day.strftime('%B %-e')
    checkout_day = checkout_day.strftime('%B %-e')

    puts "Check-in Day: #{checkin_day}"
    puts "Check-out Day: #{checkout_day}"
    [checkin_day, checkout_day]
  end

  def convert_label_to_price(price_label)
    amount_with_currency = price_label
    amount_with_currency.gsub(/[^\d.-]/, '').to_f
  end
end
