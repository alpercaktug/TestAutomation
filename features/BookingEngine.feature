@full-suite @smoke @booking-engine
Feature: Booking Engine functionality tests


  Scenario: Make a successful reservation
    Given I navigate to booking page
    When I make a reservation to "Classic Room" for 3 night
    And Fill payment page fields
    Then Verify reservation is "Confirmed"
    And Cancel reservation on result page
    And Verify reservation is "Canceled"


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
    Given I navigate to booking page
    And I make a reservation to "Classic Room" for 1 night
    When I don't fill <field>
    Then I should see <error message> under <field>
    Examples:
      | field     | error message        |
      | firstname | Can't be blank       |
      | lastname  | Can't be blank       |
      | country   | Can't be blank       |
      | email     | can't be blank       |
      | phone     | Invalid phone number |


  Scenario: Room count in reservation detail should return correct data
    Given I navigate to booking page
    When I add 1 "Classic Room" for 1 night
    And I add 1 "King Suite" for 1 night
    Then I should see 1 "Classic Room" has added on reservation details
    And I should see 1 "King Suite" has added on reservation details


  #Scenario: Room count in reservation detail should return correct
  #  Given I navigate to booking page
  #    * I add 1 "Classic Room" for 1 night
  #    * I add 1 "King Suite" for 1 night
  #  When I complete reservation
  #  Then Verify reservation is "Confirmed"
  #  And I should see 1 "Classic Room" has added on reservation details
  #  And I should see 1 "King Suite" has added on reservation details
  #  When Cancel reservation on result page
  #  Then Verify reservation is "Canceled"



  #Scenario: If room unavailable for selected day then user can't select that room
   # Given "King Suite" is unavailable for today
    #When I try to make a reservation to "King Suite" for today
     #select wrong label - need to fix
    #Then I should see room is unavailable




  # ekstra ekleyerek rezervasyon