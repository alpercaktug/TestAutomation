# frozen_string_literal: true

class DashboardPage
  include PageObject

  span(:reservations, value: 'Reservations')

  # require login??
  def visit_dashboard
    @login_page = LoginPage.new(@browser)
    @login_page.login
  end

  def navigate_reservations
    @browser.get "#{BaseUrl}admin/pms/reservations/all"
  end
end
