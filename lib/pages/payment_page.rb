# frozen_string_literal: true

class PaymentPage
  include PageObject

  text_field(:first_name, name: 'firstname')
  text_field(:last_name, name: 'lastname')
  text_field(:email, name: 'email')
  text_field(:phone, name: 'phone')
  select(:country, name: 'country_id')
  button(:complete_reservation, name: 'button')
  div(:result, class: 'state')

  def fill_contact_information
    self.first_name = 'firstname'
    self.last_name = 'lastname'
    self.country = 'Turkey'
    self.email = 'alperctest@gmail.com'
    self.phone = '5300905294'
  end

  def fill_contact_information_without(field)
    self.first_name = field == 'firstname' ? nil : 'firstname'
    self.last_name = field == 'lastname' ? nil : 'lastname'
    self.country = field == 'country' ? '' : 'Turkey'
    self.email = field == 'email' ? nil : 'alperctest@gmail.com'
    self.phone = field == 'phone' ? nil : '5300905294'
  end

  def error_message(field)
    if field == 'country'
      @browser.find_element(css: "small[class='errorExplanation hasError']").text
    else
      @browser.find_element(css: "app-form-input[formcontrolname='#{field}'] .errorExplanation").text
    end
  end

  def click_complete
    complete_reservation
  end
end
