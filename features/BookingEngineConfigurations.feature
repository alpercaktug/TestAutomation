@full-suite @booking-engine
Feature: Booking Engine Configurations

  Scenario: Auto-Confirm Paid Reservations enabled
    Given that the "Auto-confirm paid reservations" setting is "enabled"
    When Make a reservation for a "Single Room" for 2 night and 1 adult with "Mail Order"
    Then I should see the reservation is "Confirmed"

  Scenario: Auto Confirm Paid Reservations disabled
    Given that the "Auto-confirm paid reservations" setting is "disabled"
    And that the "Auto-confirm all reservations" setting is "disabled"
    When Make a reservation for a "Single Room" for 2 night and 1 adult with "Cash"
    Then I should see the reservation is "Reserved"

  Scenario Outline: Auto Confirm All Reservations enabled
    Given that the "Auto-confirm all reservations" setting is "enabled"
    When Make a reservation for a "Single Room" for 2 night and 1 adult with "<Payment Method>"
    Then I should see the reservation is "Confirmed"
    Examples:
      | Payment Method |
      | Cash           |
      | Mail order     |

  Scenario Outline: Auto Confirm All Reservations disabled
    Given that the "Auto-confirm all reservations" setting is "disabled"
    When Make a reservation for a "Single Room" for 2 night and 1 adult with "<Payment Method>"
    Then I should see the reservation is "Reserved"

    Examples:
      | Payment Method |
      | Cash           |
      | Mail order     |

  @bar
  Scenario: Make a successful reservation when best Available Rate enabled
    Given that the "Best Available Rate" setting is "enabled"
    When Make a reservation for a "Single Room" for 2 night and 1 adult with "Cash"
    Then I should see the reservation is "Confirmed"
    #Then I should see a recommended best available rate

  Scenario: Display Coupon Code as Name enabled
    Given that the "Display Coupon Code as Name" setting is "enabled"
    And Navigate to the booking page
    And Add 1 "Double Room" to the cart
    When Apply a coupon code that "820F4F"
    Then I should see the coupon name is "TESTCODE" on the reservation details

 # ayar zamanında işlemiyor
  Scenario: Display Coupon Code as Name disabled
    Given that the "Display Coupon Code as Name" setting is "disabled"
    And Navigate to the booking page
    And Add 1 "Double Room" to the cart
    When Apply a coupon code that "820F4F"
    Then I should see the coupon name is "820F4F" on the reservation details

  Scenario: Display Included Tax Total on Rooms enabled
    Given that the "Display Included Tax Total on Rooms" setting is "enabled"
    When I search for an available room for 1 night and 1 adult
    Then I should see the taxes label

  Scenario: Display Included Tax Total on Rooms disabled
    Given that the "Display Included Tax Total on Rooms" setting is "disabled"
    When I search for an available room for 1 night and 1 adult
    Then I shouldn’t see the taxes label

  Scenario: List Packages First enabled
    Given that the "List Packages First" setting is "enabled"
    And I have a "Package Test" room
      # which has a package
    When I search for an available room for 1 night and 1 adult
    Then I should see the <Package Test> room first

  Scenario: List Packages First disabled
    Given that the "List Packages First" setting is "disabled"
    And I have a <Package Test> room
      # which has a package
    When I search for an available room for 1 night and 1 adult
    Then I should see the search return normally
      # Normali nasıl?

  Scenario: Show the Deal Which Has The Best Discount Percentage Among The Same Type enabled
    Given that the "Best Discount Percentage Among The Same Type" setting is "enabled"
    And I have a <Different Rates> room
      # which has different rates
    When I search for an available room for 1 night and 1 adult
    Then I should see the Best Discount Percentage Among the room

  Scenario: Show the Deal Which Has The Best Discount Percentage Among The Same Type disabled
    Given that the "Best Discount Percentage Among The Same Type" setting is "disabled"
    And I have a <Different Rates> room
      # which has different rates
    When I search for an available room for 1 night and 1 adult
    Then # Disable da nasıl gösteriyor? Then adımı nasıl olmalı?

  Scenario: Sell Multiple Rooms enabled
    Given that the "Sell Multiple Rooms" setting is "enabled"
    And the Maximum number of rooms per reservation is 3
    When I add 3 rooms to the search
    Then I should see the add room button is disabled

  Scenario: Sell Multiple Rooms disabled
    Given that the "Sell Multiple Rooms" setting is "disabled"
    When I open the room search dropdown
    Then I should see the add room button is disabled

  Scenario: Hide Property Details Box enabled
    Given that the "Hide Property Details Box" setting is "enabled"
    When I navigate to the booking page
    Then I should see the property details box

  Scenario: Hide Property Details Box disabled
    Given that the "Hide Property Details Box" setting is "disabled"
    When I navigate to the booking page
    Then I shouldn't see the property details box

  Scenario: Hide “Packages & Deals” Tab enabled
    Given that the "Hide Packages & Deals Tab" setting is "enabled"
    When I navigate to the booking page
    Then I should see the Packages & Deals tab

  Scenario: Hide “Packages & Deals” Tab disabled
    Given that the "Hide Packages & Deals Tab" setting is "disabled"
    When I navigate to the booking page
    Then I shouldn't see the Packages & Deals tab

  Scenario: Hide “Availability Calendar” tab enabled
    Given that the "Hide Availability Calendar Tab" setting is "enabled"
    When I navigate to the booking page
    Then I should see the Availability Calendar tab
    When I navigate to the Availability Calendar
    Then I should see the tab is opened successfully

  Scenario: Hide “Availability Calendar” tab disabled
    Given that the "Hide Availability Calendar Tab" setting is "disabled"
    When I navigate to the booking page
    Then I shouldn't see the Availability Calendar tab

  Scenario: Disallow Currency Selection enabled
    Given that the "Disallow Currency Selection" setting is "enabled"
    When I navigate to the booking page
    Then I should see the currency field
    When I select the currency as <EUR>
    Then the rates should be seen in <EUR>

  Scenario: Disallow Currency Selection disabled
    Given that the "Disallow Currency Selection setting" is "disabled"
    When I navigate to the booking page
    Then I shouldn't see the currency field

  Scenario: Don’t show rate on “Availability Calendar” enabled
    Given that the "Don’t show rate on Availability Calendar" setting is "enabled"
    When I navigate to the booking page
    And I navigate to the Availability Calendar tab
    Then I should see the rates

  Scenario: Don’t show rate on “Availability Calendar” disabled
    Given that the "Don’t show rate on Availability Calendar" setting is "disabled"
    When I navigate to the booking page
    And I navigate to the Availability Calendar tab
    Then I shouldn't see the rates

  Scenario: Show Master Rate as the Original Rate of the Room Types enabled
    Given that the "Show Master Rate as the Original Rate of the Room Types" setting is "enabled"
    And I have a <Rates Test> room
      # which has rate plans
    When I search for an available room for 1 night and 1 adult
    Then I should see the original rate is the master rate

  Scenario: Show Master Rate as the Original Rate of the Room Types disabled
    Given that the "Show Master Rate as the Original Rate of the Room Types" setting is "disabled"
    And I have a <Rates Test> room
      # which has rate plans
    When I search for an available room for 1 night and 1 adult
    Then I should see WHAT?

  Scenario: List the Rooms With no availability in Search Results enabled
    Given that the "List the Rooms With no availability in Search Results" setting is "enabled"
    And I have a <Unavailable Test> room
      # which is Unavailable
    When I navigate to the booking page
    Then I should see the unavailable rooms

  Scenario: List the Rooms With no availability in Search Results disabled
    Given that the "List the Rooms With no availability in Search Results" setting is "disabled"
    And I have a <Unavailable Test> room
      # which is Unavailable
    When I navigate to the booking page
    Then I should see just the available rooms

  Scenario: Apply Restrictions With Master Rate Level enabled
    Given that the "Apply Restrictions With Master Rate Level" setting is "enabled"
    # When
    # Then

  Scenario: Apply Restrictions With Master Rate Level disabled
    Given that the "Apply Restrictions With Master Rate Level" setting is "disabled"
    # When
    # Then

  Scenario: Apply Restrictions With Master Rate Level enabled
    Given that the "Apply Restrictions With Master Rate Level" setting is "enabled"
    And I have a <Promotions Test> room
      # which has promotions
    When I search for an available room for 1 night and 1 adult
    Then I should see the promotion except for the master rate

  Scenario: Apply Restrictions With Master Rate Level disabled
    Given that the "Apply Restrictions With Master Rate Level" setting is "disabled"
    And I have a <Promotions Test> room
      # which has promotions
    When I search for an available room for 1 night and 1 adult
    Then I should see all rate plans

  Scenario: Always Recommend Room enabled
    Given that the "Always Recommend Room" setting is "enabled"
    When Navigate to the booking page
    Then I should see recommended room bar is "enable"


  Scenario: Always Recommend Room disabled
    Given that the "Always Recommend Room" setting is "disabled"
    When Navigate to the booking page
    Then I should see recommended room bar is "disable"

  Scenario: Recommend Room Only if Necessary enabled
    Given that the "Recommend Room Only if Necessary" setting is "enabled"
    When I navigate to the booking page
    Then I should see WHAT?

  Scenario: Always Recommend Room disabled
    Given that the "Recommend Room Only if Necessary" setting is "disabled"
    When I navigate to the booking page
    Then I shouldn’t see WHAT?

  Scenario: Validate Phone Number enabled
    Given that the "Validate Phone Number" setting is "enabled"
    When I search for an available room for 1 night and 1 adult
    And I add a "Classic Room" to the cart
    And I continue to the payment page and fill the phone number with the wrong format
    Then I should see an error

  Scenario: Validate Phone Number disabled
    Given that the "Validate Phone Number" setting is "disabled"
    When I search for an available room for 1 night and 1 adult
    And I add a "Classic Room" to the cart
    And I continue to the payment page and fill the phone number with the wrong format
    Then I should see the payment has been successful

  Scenario: Request Address Details enabled
    Given that the "Request Address Details" setting is "enabled"
    When I search for an available room for 1 night and 1 adult
    And I add a "Classic Room" to the cart
    And I continue to the payment page
    Then I should see the address details in the contact information form

  Scenario: Request Address Details disabled
    Given that the "Request Address Details" setting is "disabled"
    When I search for an available room for 1 night and 1 adult
    And I add a "Classic Room" to the cart
    And I continue to the payment page
    Then I shouldn’t see the address details in the contact information form

  Scenario: Request Guest Information enabled
    Given that the "Request Guest Information" setting is "enabled"
    When I search for an available room for 1 night and 1 adult
    And I add a "Classic Room" to the cart
    And I continue to the payment page
    Then I should see the guest information form
    And I should see there are fields for each guest

  Scenario: Request Guest Information disabled
    Given that the "Request Guest Information" setting is "disabled"
    When I search for an available room for 1 night and 1 adult
    And I add a "Classic Room" to the cart
    And I continue to the payment page
    Then I shouldn’t see any guest information form

  Scenario: Request HES Code enabled
    Given that the "Request HES Code" setting is "enabled"
    When I search for an available room for 1 night and 1 adult
    And I add a "Classic Room" to the cart
    And I continue to the payment page
    Then I should see the guest information form
    And I should see the HES code field for each guest

  Scenario: Request Billing Information enabled
    Given that the "Request Billing Information" setting is "enabled"
    When I make a reservation for a "Classic Room" for 1 night and 1 adult with "Pay at the property"
    Then I should see the billing information on the results

  Scenario: Request Billing Information disabled
    Given that the "Request Billing Information setting" is "disabled"
    When I make a reservation for a "Classic Room" for 1 night and 1 adult with "Pay at the property"
    Then I shouldn’t see the billing information on the results

  Scenario: Show National ID Input enabled
    Given that the "Show National ID Input" setting is "enabled"
    When I search for an available room for 1 night and 1 adult
    And I add a "Classic Room" to the cart
    And I continue to the payment page
    Then I should see the National ID input on the contact information form

  Scenario: Show National ID Input disabled
    Given that the "Show National ID Input" setting is "disabled"
    When I search for an available room for 1 night and 1 adult
    And I add a "Classic Room" to the cart
    And I continue to the payment page
    Then I shouldn’t see the National ID input on the contact information form

  Scenario: Terms of Services Checkbox Must be Checked enabled
    Given that the "Terms of Services Checkbox Must be Checked" setting is "enabled"
    When I search for an available room for 1 night and 1 adult
    And I add a "Classic Room" to the cart
    And I continue to the payment page
    Then I should see the Terms of Service checkbox
    And I verify that the Terms of Service checkbox is mandatory

  Scenario: Terms of Services Checkbox Must be Checked disabled
    Given that the "Terms of Services Checkbox Must be Checked" setting is "disabled"
    When I search for an available room for 1 night and 1 adult
    And I add a "Classic Room" to the cart
    And I continue to the payment page
    Then I shouldn’t see the Terms of Service checkbox

  Scenario: Show General Data Protection Regulation Field enabled
    Given that the "Show General Data Protection Regulation Field" setting is "enabled"
    When I search for an available room for 1 night and 1 adult
    And I add a "Classic Room" to the cart
    And I continue to the payment page
    Then I should see the Data Protection Regulation Field checkbox
    And I verify that the Data Protection Regulation Field is mandatory

  Scenario: Show General Data Protection Regulation Field disabled
    Given that the "Show General Data Protection Regulation Field" setting is "disabled"
    When I search for an available room for 1 night and 1 adult
    And I add a "Classic Room" to the cart
    And I continue to the payment page
    Then I shouldn’t see the Data Protection Regulation Field checkbox

  Scenario: If the Reservation Amount is Greater Than the Threshold, the ID Number Input is Required
    Given that the threshold field is set to 100
    And I have a "Threshold Test" room
    # with a price greater than 100
    And I add the "Threshold Test" to the cart
    And I continue to the payment page
    Then I should see the National ID input on the contact information form

  Scenario: The Number of Adults Limit Per Room
    Given that The Number of Adults Limit Per Room is set to 3
    When I add 3 adults to the search
    Then I should see the adults added successfully
    And I should see the increase adult button is disabled

  Scenario: The Number of Children Limit Per Room
    Given that The Number of Children Limit Per Room is set to 3
    When I add 3 children to the search
    Then I should see the children added successfully
    And I should see the increase children button is disabled

  Scenario: Message to be Displayed for Rooms with no Availability
    Given that the not available message is <Oda yok>
    And I have a <Unavailable Test> room
    When I navigate to the booking page
    Then I should see the "Oda yok" message under unavailable rooms
