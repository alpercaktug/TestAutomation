# frozen_string_literal: true

class Helper

  def calculate_reservation_date(night_count)
    checkin_day = Date.today
    checkout_day = checkin_day + night_count

    checkin_day = checkin_day.strftime('%B %-e')
    checkout_day = checkout_day.strftime('%B %-e')

    puts checkin_day
    puts checkout_day
    [checkin_day, checkout_day]
  end
end
