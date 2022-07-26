
@Regression
Feature: Security test. Token Verify test.

@Regression
  Scenario: Verify valid Token.
    Given url "https://tek-insurance-api.azurewebsites.net"
    And path "/api/token"
    And request {"username": "supervisor","password": "tek_supervisor"}
    When method post
    Then status 200
    * def generatedToken = response.token
    Given path "/api/token/verify"
    And param username = "supervisor"
    And param token = generatedToken
    When method get
    Then status 200
    And print response

@Regression
  Scenario: verify wrong token
    Given url "https://tek-insurance-api.azurewebsites.net"
    And path "/api/token/verify"
    And param username = "supervisor"
    And param token = "Wrong Token"
    When method get
    Then status 400
    * def errorMessage = response.errorMessage
    And assert errorMessage =="Token Expired or Invalid Token"

@Regression
  Scenario: verify /api/token/verify with Valid token but Invalid User Name. status code should be 400
    Given url "https://tek-insurance-api.azurewebsites.net"
    And path "/api/token"
    And request {"username": "supervisor","password": "tek_supervisor"}
    When method post
    Then status 200
    * def generatedToken = response.token
    Given path "/api/token/verify"
    And param username = "Wrong User"
    And param token = generatedToken
    When method get
    Then status 400
    And print response
    * def errorMessage = response.errorMessage
    And assert errorMessage =="Wrong Username send along with Token"
    And print response
