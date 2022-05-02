*** Settings ***
Library     SeleniumLibrary
Library     String
Variables   ../PageObjects/Locators.py
Resource    LoginKeywords.robot

*** Keywords ***
Login to App
    [Arguments]     ${username}     ${password}
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

Add Company
    [Arguments]     ${name}

Verify Add Company Details
    Click Element   ${add_companybtn}
    Wait Until Element Is Visible   ${addcomp_name}     15s
    Log to Console      Name field is present
    Wait Until Element Is Visible   ${addcomp_isactive}     15s
    Click Element   ${addcomp_isactive}
    Log to Console      Toggled inactive
    Click Element   ${addcomp_isactive}
    Log to Console      Toggled active again
    Wait Until Element Is Visible   ${addcomp_tabs}     15s
    ${row}=     get element count   ${addcomp_tabs}
    Log to Console      There are ${row} tabs
    ${catsum}=         Set variable    ${0}
    FOR     ${i}    IN RANGE    2   ${row}+1
        ${catbar}=      catenate    SEPARATOR=      ${addcomp_tabs}     [${i}]
        ${catrate}=     get text    ${catbar}
        Log to Console  item[${i}]: ${catrate}
    END
    Wait Until Element Is Visible   ${date_navbar}      10s
