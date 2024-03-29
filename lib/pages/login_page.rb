# frozen_string_literal: true

class LoginPage
  include PageObject


  text_field(:mail, id: 'user_email')
  text_field(:password, id: 'user_password')
  button(:login_button, name: 'commit')
  div(:logout_button, value: 'Log out')
  link(:profile, title: 'Profile')
  checkbox(:remember_me, id: 'remember-me')

  link(:settings, xpath: '//a[@aria-controls="settings-tab-form"]')
  link(:configurations, xpath: '//a[contains(@onclick, "configuration")]')
  checkbox(:bar, xpath:'//input[contains(@id, "bar")]')
  button(:save, xpath: '//input[@name="commit"]')

  #hidden_checkbox(:bar2, label:'preferred_settings_store_preferred_bar_rate_enabled')

  def visit_login_page
    @browser.get 'https://testautomation.hotelrunner.com/admin'
  end

  def visit_dashboard_page
    @browser.get 'https://testautomation.hotelrunner.com/admin?hk=0&hr_id=207989710&token=X-ODInYIgT06cCTjRq3-pXvpC_xQ8ArS3GSzFNv-&api_key=aa68be3e116ed7c354fae33ed17633f8bb534eaea522dfe4&mobile_app=true&from_api_app=true&locale=tr'
  end

  def fill_credentials
    self.mail = 'hrtestautomation@gmail.com'
    self.password = 'hrtestautomation'
    check_remember_me
  end

  def click_login_button
    login_button
  end

  def logout
    @browser.get 'https://staging.hotelrunner.com/user/sign_out'
  end
  def login
    visit_login_page
    fill_credentials
    click_login_button
  end
end
