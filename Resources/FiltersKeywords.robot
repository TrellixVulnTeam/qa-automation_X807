*** Settings ***
Library     SeleniumLibrary
Library     String
Variables   ../PageObjects/Locators.py
Resource    LoginKeywords.robot

*** Keywords ***
Click filter dropdown
    Wait until Element is Visible
