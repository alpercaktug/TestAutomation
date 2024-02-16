@booking-engine
Feature: Booking Engine functionality tests

  @reservation
  Scenario: Make a successful reservation
    * Make a reservation
    * Fill payment page fields
    * Verify reservation is "Confirmed"
    * Cancel reservation on result page
    * Verify reservation is "Canceled"



