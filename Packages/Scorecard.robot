*** Settings ***
Library     SeleniumLibrary
Resource    ../Resources/ScorecardKeywords.robot

#Suite Setup runs only once
Suite Setup     Setup Properties
Suite Teardown  Close All Browsers

*** Variables ***
${browser}  chrome
${url}      https://accounts.detailonline.com/
${user}     razer-own@mailinator.com
${pass}     d3t@1l@dm1n

*** Test Cases ***
Scorecard: Verify access to page
    [Tags]  start
    Element should be Visible   ${scorecard}
    Log to Console  Score Card is accessed.
Scorecard: Verify contents on page
    Check Score Card Contents
Scorecard: Verify date picker if working properly
    [Tags]  filter
    Check calendar
    Check month slider
    Check year slider
Scorecard: Verify Display Overall calculation
    [Tags]  display
    Verify Display Pillar Score
Scorecard: Verify Inspire Overall calculation
    [Tags]  inspire
    Verify Inspire Pillar Score
Scorecard: Verify Convert Overall calculation
    [Tags]  convert
    Verify Convert Pillar Score
Scorecard: Verify Overall % calculation
    [Tags]  overall
    Verify Overall Score


#1.0 Scorecard: Verify Scorecard variance % calculation
#    [Tags]  variance
#    Verify Overall Score Variance

*** Keywords ***
Setup Properties
    Launch Browser      ${url}      headlesschrome      #${browser}      #
    Login to App        ${user}     ${pass}
    Set Selenium Speed  2s
    Set Selenium Timeout  60s