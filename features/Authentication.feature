@full-suite @authentication
Feature: Authentication functionality tests

  @login
  Scenario: Make a successful login to HotelRunner
    * Navigate to login page
    * Fill user credentials
    * Click login button
    #* Verify login is successful
    * Navigate to logout
