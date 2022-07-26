@Regression
Feature: New accounts Scenarios

  Background: 
    Given url "https://tek-insurance-api.azurewebsites.net"
    * def createAccountResult = callonce read('CreateAccountFeature.feature')
    And print createAccountResult
    * def primaryPersonId = createAccountResult.response.id
    * def email = createAccountResult.response.email
    * def title = createAccountResult.response.title
    * def firstName = createAccountResult.response.firstName
    * def lastName = createAccountResult.response.lastName
    * def gender = createAccountResult.response.gender
    * def maritalStatus = createAccountResult.response.maritalStatus
    * def employmentStatus = createAccountResult.response.employmentStatus
    * def dateOfBirth = createAccountResult.response.dateOfBirth
    * def user = createAccountResult.response.user
    * def token = createAccountResult.result.response.token

  #Scenario: Create new Account Happy pass
  #Given path "/api/accounts/add-primary-account"
  #And request
  #"""
  #{"email": "yahya-api-automation10@gmail.com",
  #"title": "Mr.",
  #"firstName": "SayedYahya",
  #"lastName": "Hussaini",
  #"gender": "MALE",
  #"maritalStatus": "MARRIED",
  #"employmentStatus": "student",
  #"dateOfBirth": "1989-20-07"}
  #"""
  #		And header Authorization = "Bearer "+generatedToken
  #		When method post
  #Then status 201
  #* def generatedId = response.id
  #And print generatedId
  #And print response
  @Regression
  Scenario: Add new Account with Existing Email address
    Given path "/api/accounts/add-primary-account"
    And request
      """
      {
      "email": "#(email)",
      "title": "#(title)",
      "firstName": "#(firstName)",
      "lastName": "#(lastName)",
      "gender": "#(gender)",
      "maritalStatus": "#(maritalStatus)",
      "employmentStatus": "#(employmentStatus)",
      "dateOfBirth": "#(dob)"
      "user": "#(user)"
      }
      """
    And header Authorization = "Bearer "+generatedToken
    When method post
    Then status 400
    * def errorCode = response.errorCode
    * def httpStatus = response.httpStatus
    * def dataBaseResponse = response.errorMessage
    And assert errorCode =="ACCOUNT_EXIST"
    And assert httpStatus =="BAD_REQUEST"
    And assert dataBaseResponse =="Account with Email yahya-api-automation10@gmail.com is exist"
    And print response

  @Regression
  Scenario: Add car to existing Account
    Given path "/api/accounts/add-account-car"
    And param primaryPersonId = primaryPersonId
    And request
      """
      {"make": "Volvo",
      "model": "XC90",
      "year": "2023",
      "licensePlate": "YLF-2922"}
      """
    And header Authorization = "Bearer "+token
    When method post
    Then status 201
    And print response

  @Regression
  Scenario: Add Phone Number to Existing Account
    Given path "/api/accounts/add-account-phone"
    And param primaryPersonId = primaryPersonId
    And request
      """
      {"phoneNumber": "5404566983",
      "phoneExtension": "N/A",
      "phoneTime": "Evening",
      "phoneType": "Mobile"}
      """
    And header Authorization = "Bearer "+token
    When method post
    Then status 201
    And print response

  @Regression
  Scenario: Add Address to Existing Account
    Given path "/api/accounts/add-account-address"
    And param primaryPersonId = primaryPersonId
    And header Authorization = "Bearer "+token
    And request
      """
      {"addressType": "Apartment",
      "addressLine1": "5342 Mountain Rd",
      "city": "GlenAllen",
      "state": "Virginia",
      "postalCode": "5342",
      "countryCode": "+1",
      "current": true
      }
      """
    When method post
    Then status 201
    And print response
