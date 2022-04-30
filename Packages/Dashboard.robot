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