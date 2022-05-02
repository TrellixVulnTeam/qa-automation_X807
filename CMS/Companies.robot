*** Settings ***
Library     SeleniumLibrary
Library     String
Resource    ../Resources/CompaniesKeywords.robot

#Suite Setup runs only once. headlesschrome is used to run in the background
Suite Setup     Launch Browser      ${url}      ${browser}
#Suite Teardown happens at the very end of execution
Suite Teardown  Close All Browsers

# Test Setup and Teardown runs for every test case
Test Setup      Setup Properties
Test Teardown   Teardown Properties

*** Variables ***
${browser}  chrome
${url}      https://detail-cms-staging.azurewebsites.net/
${admin}    rica.datoc@detailonline.tech
${admin_pass}       ricadatoc123

*** Test Cases ***
Login - Login using correct credentials
    [Tags]  login
    Log to console  Input correct email address
    Input Username  ${admin}
    Log to console  Input correct password
    Input Password  ${admin_pass}
    Log to Console  Select password seeker on login form
    Un/Hide Password
    Log to Console  Select login button
    Click Login
    Verify CMS Login Success
#    Logout CMS Admin

Companies - Add Companies
    [Tags]  add
    Verify Add Company Details


*** Keywords ***
Setup Properties
    Set Selenium Speed  2s
    Set Selenium Timeout  60s
Browser Properties
    Launch Browser      ${url}      ${browser}
Teardown Properties
    Sleep   5s
