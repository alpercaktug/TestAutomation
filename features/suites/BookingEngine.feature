@smoke @booking-engine
Feature: Booking Engine functionality tests

  Scenario: Make a successful reservation
    * Make a reservation
      | Checkin     | Checkout    |
      | February 25 | February 27 |
    * Fill payment page fields
    * Verify reservation is "Confirmed"
    * Cancel reservation on result page
    * Verify reservation is "Canceled"


  Scenario Outline: : Reservation detail information should return correct data
    Given I navigate to booking page
    When I select check-in and check-out day for <night> night
    Then I should see correct <night> information on reservation detail
    Examples:
      | night |
      | 1     |
      | 2     |
      | 7     |
      | 30    |


  Scenario Outline: Mandatory field controls on payment page
    Given Make a reservation to "Classic Room"
    When I don't fill <field>
    Then I should see <error message> under <field>
    Examples:
      | field     | error message        |
      | firstname | Can't be blank       |
      | lastname  | Can't be blank       |
      | country   | Can't be blank       |
      | email     | can't be blank       |
      | phone     | Invalid phone number |


  Scenario: If room unavailable for selected day then user can't select that room
    Given "King Suite" is unavailable for today
    When I try to make a reservation to "King Suite" for today
     #select wrong label - need to fix
    Then I should see room is unavailable
