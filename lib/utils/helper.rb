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

  def self.settings_mapping(text)
    mappings = {
      'Auto-confirm paid reservations' => 'preferred_settings_store_preferred_auto_confirm_paid_reservations',
      'Auto-confirm all reservations' => 'preferred_settings_store_preferred_auto_confirm_all_reservations',
      'Best Available Rate' => 'preferred_settings_store_preferred_bar_rate_enabled',
      'Always Recommend Room' => 'preferred_settings_store_preferred_always_recommend_room',
      'Display Coupon Code as Name' => 'preferred_settings_store_preferred_display_coupon_code_as_name'
      # Add more mappings as needed
    }
    mappings[text]
  end

  # Test automation hotel room locators with name attribute
  def room_locator_mapping(text)
    mappings = {
      'Single Room' => 'buttona804051',
      'Double Room' => 'buttona787279',
      'Extras Room' => 'buttona793471',
      'Bar Room' => 'buttona787278',
      'Family Room' => 'buttona787285'
      # Add more mappings as needed
    }
    mappings[text]
  end
end
