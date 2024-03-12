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

  # Broken
  def find_parent_element_id(inner_text)
    script = <<-JS
    function findParentIdByInnerText(innerText) {
      var elements = document.querySelectorAll('.room-details h3.title');
      for (var i = 0; i < elements.length; i++) {
        if (elements[i].innerText.trim() === innerText) {
          return elements[i].closest('.room').id;
        }
      }
      return null;
    }

    return findParentIdByInnerText(arguments[0]);
    JS

    @browser.execute_script(script, inner_text)
  end
end
