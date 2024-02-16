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
    self.last_name = "lastname"
    self.email = "alperctest@gmail.com"
    self.country = "Turkey"
    self.phone = "5300905294"
  end

  def click_complete
    complete_reservation
  end
end
