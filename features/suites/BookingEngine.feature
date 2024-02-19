@booking-engine
Feature: Booking Engine functionality tests

  @reservation
  Scenario: Make a successful reservation
    * Make a reservation
      | Checkin     | Checkout    |
      | February 25 | February 27 |
    * Fill payment page fields
    * Verify reservation is "Confirmed"
    * Cancel reservation on result page
    * Verify reservation is "Canceled"


  Scenario: If room unavailable for selected day then user can't select that room
    Given "King Suite" is unavailable for today
    When I try to make a reservation to "King Suite" for today
    Then I should see room is unavailable
    #* Make a reservation to
    #* Fill payment page fields
    #* Verify reservation is "Confirmed"
    #* Navigate to booking page and verify room is unavailable







