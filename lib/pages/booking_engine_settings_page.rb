# frozen_string_literal: true

class BookingEngineSettingsPage
  include PageObject

  link(:settings, xpath: '//a[@aria-controls="settings-tab-form"]')
  link(:configurations, xpath: '//a[contains(@onclick, "configuration")]')
  checkbox(:bar, xpath: '//input[contains(@id, "bar")]')
  button(:save, xpath: '//input[@name="commit"]')

  def visit_settings_page
    @browser.get 'https://testautomation.hotelrunner.com/admin/booking/engine/customizations'
    settings
    configurations
    self
  end

  def enable_setting(setting, ability)
    sleep 5
    if ability == 'enabled'
      check_bar
      sleep 5
    elsif ability == 'disabled'
      uncheck_bar
      sleep 5
    end
    save
    sleep 5
  end
end

