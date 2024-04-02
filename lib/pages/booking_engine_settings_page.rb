# frozen_string_literal: true

class BookingEngineSettingsPage < BasePage
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
    sleep 3
    check_checkbox(setting, ability)
    save
    sleep 3
  end
end

