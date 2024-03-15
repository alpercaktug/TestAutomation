# frozen_string_literal: true

class ResultPage
  include PageObject

  div(:result_state, class: 'state')
  link(:cancel, class: 'cancellation-btn')
  button(:yes, class: 'prmry')
  div(:result, xpath: '//div[contains(@class, "success")]')


  def click_cancel
    cancel
    self
  end

  def click_yes
    yes
    self
  end

  def state_present?(state)
    result_state.include?(state)
  end


  def result
    puts result_element.text
    result_element.text
  end
end
