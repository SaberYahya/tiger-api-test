@Regression
Feature: Create an account and add address to the account

  Background: Create new Account.
    Given url "https://tek-insurance-api.azurewebsites.net"
    * def createAccountResult = callonce read('CreateAccountFeature.feature')
    And print createAccountResult
    * def primaryPersonId = createAccountResult.response.id
    * def token = createAccountResult.result.response.token

  @Regression
  Scenario: Add address to an account
    Given path '/api/accounts/add-account-address'
    And param primaryPersonId = primaryPersonId
    And header Authorization = "Bearer "+token
    And print token
    And request
      """
      {
      "addressType": "Apartment",
      "addressLine1": "54322 NakojaAbad Ave",
      "city": "Gainsville",
      "state": "Virginia",
      "postalCode": "45678",
      "countryCode": "+1",
      "current": true
      }
      """
    When method post
    Then status 201
    And print response
