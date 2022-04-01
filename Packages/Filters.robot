*** Settings ***
Library     SeleniumLibrary
Resource    ../Resources/FiltersKeywords.robot

#Suite Setup runs only once
Suite Setup     Setup Properties
Suite Teardown  Close All Browsers

*** Variables ***
${browser}  chrome
${url}      https://accounts.detailonline.com/
${user}     msprice-own@mailinator.com
${pass}     d3t@1l@dm1n

*** Test Cases ***
1.0 Filters: Verify date filter
    Check Date filter

*** Keywords ***
Setup Properties
    Launch Browser      ${url}      ${browser}
    Login to App        ${user}     ${pass}
    Set Selenium Speed  2s
    Set Selenium Timeout  60s