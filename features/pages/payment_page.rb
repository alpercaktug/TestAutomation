# frozen_string_literal: true

class PaymentPage
  include PageObject

  text_field(:first_name, name: "firstname")
  text_field(:last_name, name: "lastname")
  text_field(:email, name: "email")
  text_field(:phone, name: "phone")
  select(:country, name: "country_id")
  button(:complete_reservation, name: "button")
  div(:result, class: "state")

  def fill_contact_information
    self.first_name = "firstname"
    sleep(1)
    self.last_name = "lastname"
    sleep(1)
    self.country = "Turkey"
    sleep(1)
    self.email = "alperctest@gmail.com"
    sleep(1)
    self.phone = "5300905294"
    sleep(1)
  end

  def click_complete
    complete_reservation
    sleep(1)
  end
end
