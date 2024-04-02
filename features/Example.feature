Feature: Example tests

  Scenario: Example test scenario
    Given This step specifies the initial conditions of the test
    When This step represents the moment when the system performs a specific action or an event occurs
    Then This step is used to evaluate whether the test was successful or not

  Scenario: Make a successful reservation x(with data table)
    And I have the following data
      | Night | Adult Count | Child Count | Room Type    | Payment Method |
      | 1     | 2           | 0           | Classic Room | Bank Transfer  |
    When Make a reservation with the data
    Then I should see the reservation is "Confirmed"

  Scenario: Make a successful reservation (with partial steps)
    Given Navigate to the booking page
    When Search for an available room for 1 night
    And Search for an available room for 1 adult
    And Add 1 "Double Room" to the cart
    And Apply a coupon code that "820F4F"
    And Click continue
    And Fill contact form
    And Complete the reservation with pay at the property
    Then I should see the reservation is "Confirmed"


  Scenario: Make a successful reservation (with parameters)
    Given Navigate to the booking page
    When Make a reservation for a "Classic Room" for 1 night and 1 adult with "Bank Transfer"
    Then I should see the reservation is "Confirmed"



