# frozen_string_literal: true

class PaymentPage < BasePage
  include PageObject

  # Contact Form Locators
  text_field(:first_name, name: 'firstname')
  text_field(:last_name, name: 'lastname')
  text_field(:email, name: 'email')
  text_field(:phone, name: 'phone')
  select(:country, name: 'country_id')
  button(:complete_reservation, xpath: '//button[@name="button"]')

  # Mail Order Form locators
  text_field(:number, name: 'number')
  text_field(:expire, name: 'expiry')
  text_field(:cvc, name: 'cvc')
  text_field(:firstname, name: 'first-name')
  text_field(:lastname, name: 'last-name')

  # Label & Message Locators
  div(:invalid_card_message, css: 'div[class$="ng-star-inserted"]')
  div(:result, class: 'state')

  def fill_contact_information
    self.first_name = 'firstname'
    self.last_name = 'lastname'
    self.country = 'Turkey'
    self.email = 'alperctest@gmail.com'
    self.phone = '5300905294'
    self
  end

  def fill_contact_information_without(field)
    self.first_name = field == 'firstname' ? nil : 'firstname'
    self.last_name = field == 'lastname' ? nil : 'lastname'
    self.country = field == 'country' ? '' : 'Turkey'
    self.email = field == 'email' ? nil : 'alperctest@gmail.com'
    self.phone = field == 'phone' ? nil : '5300905294'
    self
  end

  def fill_card_form(number, cvc, expire, firstname, lastname)
    self.number = number
    self.expire = expire
    self.cvc = cvc
    self.firstname = firstname
    self.lastname = lastname
    self
  end

  def select_payment_method(payment_method)
    case payment_method
    when 'Cash'
      click(:xpath, '//a[@id="935795127-link"]/span')
    when 'Mail Order'
      click(:xpath, '//a[@id="935795143-link"]/span')
    when 'Bank Transfer'
      click(:xpath, '//a[@id="935790797-link"]/span')
    else
      puts 'Wrong payment method'
    end
    self
  end

  def click_complete
    complete_reservation
    ResultPage.new(@browser)
  end

  def error_message
    get_text(:css, "small[class='errorExplanation hasError']")
  end

  def invalid_card?
    puts invalid_card_message
    invalid_card_message?
  end
end
