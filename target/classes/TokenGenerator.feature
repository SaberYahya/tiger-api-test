
@Regression
Feature: Token Generator for CSR portal

  Scenario: Generate Valid Token with CSR Supervisor user.
    Given url "https://tek-insurance-api.azurewebsites.net"
    And path "/api/token"
    And request {"username": "supervisor","password": "tek_supervisor"}
    When method post
    Then status 200
    And print response
