# frozen_string_literal: true

class PaymentPage < BasePage
  include PageObject

  text_field(:first_name, name: 'firstname')
  text_field(:last_name, name: 'lastname')
  text_field(:email, name: 'email')
  text_field(:phone, name: 'phone')
  select(:country, name: 'country_id')
  button(:complete_reservation, name: 'button')
  div(:result, class: 'state')

  text_field(:number, name: 'number')
  text_field(:expiry, name: 'expiry')
  text_field(:cvc, name: 'cvc')
  text_field(:firstname, name: 'first-name')
  text_field(:lastname, name: 'last-name')

  div(:invalid_card_message, css: 'div[class$="ng-star-inserted"]')

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

  def error_message
    get_text(:css, "small[class='errorExplanation hasError']")
  end

  def click_complete
    complete_reservation
    ResultPage.new(@browser)
  end


  def invalid_card?
    puts invalid_card_message
    invalid_card_message?
  end

  def fill_number(number)
    self.number = number
    self
  end
  def fill_expiry(expiry)
    self.expiry = expiry
    self
  end
  def fill_cvc(cvc)
    self.cvc = cvc
    self
  end
  def fill_firstname(firstname)
    self.firstname = firstname
    self
  end
  def fill_lastname(lastname)
    self.lastname = lastname
    self
  end

  def fill_card_form(number, cvc, expire, firstname, lastname)
    fill_number number
    fill_expiry expire
    fill_cvc cvc
    fill_firstname firstname
    fill_lastname lastname
  end

  def select_payment_method(payment_method)
    case payment_method
    when 'Pay at the property'
      click(:xpath, '//a[@id="935790758-link"]/span')
    when 'Mail order'
      click(:xpath, '//a[@id="935791103-link"]/span')
    when 'Bank Transfer'
      click(:xpath, '//a[@id="935790797-link"]/span')
    else
      puts 'Wrong payment method'
    end
    self
  end

end
