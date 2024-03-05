# frozen_string_literal: true

class ResultPage
  include PageObject

  div(:result_state, class: 'state')
  link(:cancel, class: 'cancellation-btn')
  button(:yes, class: 'prmry')

  def state_present?(state)
    result_state.include?(state)
  end

  def click_cancel
    cancel
  end

  def click_yes
    yes
  end
end
