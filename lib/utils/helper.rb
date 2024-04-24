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
    @test_data = YAML.load_file('config/test_data.yml')

    mappings = {
      'Standard Room' => @test_data[ENVIRONMENT][0]['Standard Room'],
      'Single Room' => @test_data[ENVIRONMENT][1]['Single Room'],
      'Double Room' => @test_data[ENVIRONMENT][2]['Double Room'],
      'Extras Room' => @test_data[ENVIRONMENT][3]['Extras Room'],
      'Bar Room' => @test_data[ENVIRONMENT][4]['Bar Room'],
      'Family Room' => @test_data[ENVIRONMENT][5]['Family Room']
      # Add more mappings as needed
    }
    mappings[text]
  end
end
