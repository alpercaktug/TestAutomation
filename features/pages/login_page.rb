# frozen_string_literal: true

class LoginPage
  include PageObject

  text_field(:mail, id: "user_email")
  text_field(:password, id: "user_password")
  button(:login_button, name: "commit")
  div(:logout_button, value: 'Log out')
  link(:profile, title:"Profile")

  def visit_login_page
    @browser.get 'https://app.hotelrunner.com/login'
  end

  def fill_credentials
    sleep(2)
    self.mail = "alperctest@gmail.com"
    sleep(2)
    self.password = "mS0451-03"
    sleep(2)
  end

  def click_login_button
    login_button
    sleep(2)
  end

  def logout
    @browser.get 'https://app.hotelrunner.com/user/sign_out'
  end

  def login
    visit_login_page
    fill_credentials
    click_login_button
  end
end
