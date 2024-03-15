# frozen_string_literal: true

class BookingEngineSettingsPage < BasePage
  include PageObject

  checkbox(:auto_confirm_paid_reservations, id: 'preferred_settings_store_preferred_auto_confirm_paid_reservations')


  def visit
    @browser.get 'https://testautomation.hotelrunner.com/admin/booking/engine/customizations'
  end


  def enable_auto_confirm_paid_reservations
    check_auto_confirm_paid_reservations
  end
end
