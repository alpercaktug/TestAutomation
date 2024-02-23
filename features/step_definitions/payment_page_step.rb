require_relative '../pages/payment_page'


When(/^Fill payment page fields$/) do
  @payment_page = PaymentPage.new(@browser)
  @payment_page.fill_contact_information
  @payment_page.click_complete
end


When(/^I don't fill (.*)$/) do |field|
  @payment_page = PaymentPage.new(@browser)
  @payment_page.fill_contact_information_without(field)
  @payment_page.click_complete
end

Then(/^I should see (.*) under (.*)$/) do |error_message, field|
  expect(@payment_page.error_message(field)).to eql error_message
end