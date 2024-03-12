@full-suite @smoke @booking-engine
Feature: Booking Engine functionality tests

  @cancel
  Scenario: Make a successful reservation (with data table)
    Given I have the following data
      | Night | Adult Count | Child Count | Room Type    | Payment Method |
      | 1     | 2           | 0           | Classic Room | Bank Transfer  |
    When I make a reservation with the data
    Then I should see the reservation is "Confirmed"

  @cancel
  Scenario: Make a successful reservation (with partial steps)
    Given I navigate to the booking page
    When I search for an available room for 1 night and 1 adult
    * I add 1 "Classic Room" to the cart
    * I continue to the payment page
    * I fill contact form
    * I complete the reservation with bank transfer
    Then I should see the reservation is "Confirmed"


  Scenario: View Available Rooms
    Given I navigate to the booking page
    When I search for an available room for 1 night and 1 adult
    Then I should see a list of available rooms
    And the prices for each room should be displayed


  Scenario: Cancel a reservation on result page
    Given I have the following data
      | Night | Adult Count | Child Count | Room Type    | Payment Method |
      | 1     | 2           | 0           | Classic Room | Mail order     |
    When I make a reservation with the data
    And Cancel reservation on result page
    Then Verify reservation is "Canceled"


  Scenario Outline: Reservation detail information should return correct data
    Given I navigate to the booking page
    When I search for an available room for <night> night and 1 adult
    Then I should see correct <night> information on reservation detail
    Examples:
      | night |
      | 1     |
      | 7     |
      | 30    |


  Scenario Outline: View Rooms with Different Occupancy
    Given I navigate to the booking page
    When I search for an available room for <night> night and <occupancy> adult
    And I add 1 "<Room Type>" to the cart
    Then I should see the total price for the reservation
    Examples:
      | Room Type    | night | occupancy |
      | Classic Room | 2     | 1         |
      | King Suite   | 3     | 2         |
      | Classic Room | 4     | 3         |
      | Classic Room | 1     | 4         |


  Scenario: Room count in reservation detail should return correct data
    Given I navigate to the booking page
    When I add 2 "Classic Room" to the cart
    And I add 1 "King Suite" to the cart
    Then I should see 2 "Classic Room" has added on reservation details
    And I should see 1 "King Suite" has added on reservation details


  Scenario Outline: Mandatory field controls on payment page
    Given I navigate to the booking page
    When I make a reservation to "Classic Room" for 1 night without filling "<field>" on payment page
    Then I should see <error message> under <field>
    Examples:
      | field     | error message        |
      | firstname | Can't be blank       |
      | lastname  | Can't be blank       |
      | country   | Can't be blank       |
      | email     | can't be blank       |
      | phone     | Invalid phone number |


  Scenario: Card number should valid
    Given I navigate to the booking page
    When I search for an available room for 1 night and 1 adult
    * I add 1 "Classic Room" to the cart
    * I continue to the payment page
    * I fill contact form
    And I complete the reservation with mail order
      | Number | CVC | Expire | Firstname | Lastname |
      | 123    | 000 | 01/27  | first     | last     |
    Then I should see invalid card number message












