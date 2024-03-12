Feature: Booking Engine example tests

  @cancel
  Scenario: Make a successful reservation (with data table)
    Given I have the following data
      | Night | Adult Count | Child Count | Room Type    | Payment Method |
      | 1     | 2           | 0           | Classic Room | Bank Transfer  |
    When I make a reservation with the data
    Then I should see the reservation is "Confirmed"


  Scenario: Make a successful reservation (with partial steps)
    Given I navigate to the booking page
    When I search for an available room for 1 night and 1 adult
    And I add 1 "Classic Room" to the cart
    And I continue to the payment page
    And I fill contact form
    And I complete the reservation with bank transfer
    Then I should see the reservation is "Confirmed"


  Scenario: Make a successful reservation (with parameters)
    Given I navigate to the booking page
    When I make a reservation for a "Classic Room" for 1 night and 1 adult with "Bank Transfer"
    Then I should see the reservation is "Confirmed"