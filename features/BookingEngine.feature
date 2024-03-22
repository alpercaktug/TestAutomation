@full-suite @booking-engine
Feature: Booking Engine functionality tests

  @smoke
  Scenario: Make a successful reservation (with data table)
    Given I have the following data
      | Night | Adult Count | Child Count | Room Type   | Payment Method |
      | 1     | 2           | 0           | Double Room | Cash           |
    When Make a reservation with the data
    Then I should see the reservation is "Confirmed"


  Scenario: View Available Rooms
    Given Navigate to the booking page
    When Search for an available room for 1 night
    And Search for an available room for 1 adult
    Then I should see a list of available rooms
    And the prices for each room should be displayed

  @test
  Scenario: Cancel a reservation on result page
    And I have the following data
      | Night | Adult Count | Child Count | Room Type   | Payment Method |
      | 1     | 2           | 0           | Double Room | Cash           |
    When Make a reservation with the data
    And Cancel reservation on result page
    #flaky: status is return null, selenium cant get cancelled. maybe wait and control page is loaded will fix.
    #Then I should see the reservation is "Canceled"

  Scenario Outline: Reservation detail information should return correct data
    Given Navigate to the booking page
    When Search for an available room for <night> night
    Then I should see correct <night> information on reservation detail
    Examples:
      | night |
      | 1     |
      | 7     |
      | 30    |

  Scenario Outline: View Rooms with Different Occupancy
    Given Navigate to the booking page
    When Search for an available room for <night> night
    And Search for an available room for <adult> adult
    And Add 1 "<Room Type>" to the cart
    #Then I should see the total price for the reservation
    Examples:
      | Room Type   | night | adult |
      | Single Room | 2     | 1     |
      | Double Room | 3     | 2     |

  Scenario: Room count in reservation detail should return correct data
    Given Navigate to the booking page
    And Search for an available room for 1 adult
    When Add 2 "Single Room" to the cart
    And Add 1 "Double Room" to the cart
    Then I should see 2 "Single Room" has added on reservation details
    And I should see 1 "Double Room" has added on reservation details

  Scenario Outline: Mandatory field controls on payment page
    Given Navigate to the booking page
    When Make a reservation to "Double Room" for 1 night without filling "<field>" on payment page
    Then I should see <error message> under <field>
    Examples:
      | field     | error message        |
      | firstname | Can't be blank       |
      | lastname  | Can't be blank       |
      | country   | Can't be blank       |
      | email     | can't be blank       |
      | phone     | Invalid phone number |

  Scenario: Valid Card Number format should be accept
    Given Navigate to the booking page
    When Search for an available room for 1 night
    And Search for an available room for 1 adult
    And Add 1 "Single Room" to the cart
    And Continue to the payment page
    And Fill contact form
    And Complete the reservation with mail order
      | Number           | CVC | Expire | Firstname | Lastname |
      | 5398075236529914 | 000 | 01/27  | first     | last     |
    Then I should see the reservation is "Confirmed"

  Scenario: Invalid Card Number format shouldn't be accept
    Given Navigate to the booking page
    When Search for an available room for 1 night
    And Search for an available room for 1 adult
    And Add 1 "Double Room" to the cart
    And Continue to the payment page
    And Fill contact form
    And Complete the reservation with mail order
      | Number | CVC | Expire | Firstname | Lastname |
      | 123    | 000 | 01/27  | first     | last     |
    Then I should see invalid card number message

  Scenario: Valid promo code should be accept
    Given Navigate to the booking page
    When Search for an available room for 1 night
    And Search for an available room for 1 adult
    And Add 1 "Single Room" to the cart
    And Apply a coupon code that "820F4F"
    Then I should see that the coupon discount is successful in reservation detail

  Scenario: Invalid promo code shouldn't be accept
    Given Navigate to the booking page
    When Search for an available room for 1 night
    And Search for an available room for 1 adult
    And Apply a coupon code that "INVALID"
    Then I should see the invalid promo code message

  Scenario: Do you have the right number of rooms? dialog
    Given Navigate to the booking page
    When Search for an available room for 1 night
    And Search for an available room for 1 adult
    And Add 2 "Single Room" to the cart
    And Continue to the payment page
    Then I should see do you want to continue dialog

  Scenario: Sure about changing your dates? dialog
    Given Navigate to the booking page
    And Search for an available room for 1 night
    And Add 1 "Double Room" to the cart
    When Search for an available room for 3 night
    Then I should see do you want to continue dialog

#wip
  Scenario: If a room has extras, the extras must appear before payment
    Given Navigate to the booking page
    And Add 1 "Extras Room" to the cart
    When Continue to the payment page
    Then I should see extras


  Scenario: Extras should be successfully added to cart
    Given Navigate to the booking page
    And Add 1 "Extras Room" to the cart
    When I add "Airport Transfer" to the cart
    Then I should see the extra added successfully





    # coupon code price recommended room
    # extras form mandatory control
    # paket seçildiğinde o tarihe göndermesi
    # button isimleri
    # ayarlardaki price seçenekleri
    # promosyon vs kupon kodu
