@full-suite @smoke @authentication
Feature: Authentication functionality tests

  @login
  Scenario: Make a successful login to HotelRunner
    * Navigate to login page
    * Fill user credentials
    * Click login button
    #* Verify login is successful
    * Navigate to logout

  #Scenario: Make a successful login to HotelRunner
  #  Given User login to hotelrunner
   # When User logs in correctly
    #Then User can access to dashboard



  Scenario: As an existing user, I want to log in successfully.
    Given the user navigates to the Login page
    When the user enters the username and password
    Then the successful login message is displayed