# frozen_string_literal: true

After('@cancel') do
  step 'Cancel reservation on result page'
  step 'I should see the reservation is "Canceled"'
  puts 'Reservation canceled'
end
