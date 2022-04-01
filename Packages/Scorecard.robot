*** Settings ***
Library     SeleniumLibrary
Resource    ../Resources/ScorecardKeywords.robot

#Suite Setup runs only once
Suite Setup     Setup Properties
Suite Teardown  Close All Browsers

*** Variables ***
${browser}  chrome
${url}      https://accounts.detailonline.com/
${user}     msprice-own@mailinator.com
${pass}     d3t@1l@dm1n

*** Test Cases ***
1.0 Scorecard: Verify access to page
    [Tags]  start
    Element should be Visible   ${scorecard}
    Log to Console  Score Card is accessed.
1.0 Scorecard: Verify contents on page
    Check Score Card Contents
1.0 Scorecard: Verify date picker if working properly
    [Tags]  filter
    Check calendar
    Check month slider
    Check year slider
#1.0 Scorecard: Verify Overall % calculation
#    [Tags]  compute
#    Verify Overall Score
#    Verify Display Pillar Score
#    Verify Inspire Pillar Score
#    Verify Convert Pillar Score

#I CAN'T FREAKING ACCESS THE SCORE TREND!!!!!!
#1.0 Scorecard: Verify Scorecard variance % calculation
#    [Tags]  variance
#    Verify Overall Score Variance

*** Keywords ***
Setup Properties
    Launch Browser      ${url}      ${browser}
    Login to App        ${user}     ${pass}
    Set Selenium Speed  2s
    Set Selenium Timeout  60s