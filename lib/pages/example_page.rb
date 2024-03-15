# frozen_string_literal: true

class ExamplePage < BasePage
  include PageObject

  text_field(:text, id: 'user_email')
  text_field(:password, id: 'user_password')
  button(:login_button, name: 'Login')
  div(:logout_button, value: 'Logout')
  link(:profile, title: 'Profile')

  def visit_example_page
    @browser.get 'https://example-page.com'
  end
end
