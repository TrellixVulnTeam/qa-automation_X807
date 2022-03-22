*** Settings ***
Library     SeleniumLibrary
Variables   ../PageObjects/Locators.py

*** Keywords ***
Launch Browser
    [Arguments]     ${siteurl}  ${testbrowser}
    Log to console  Launching Browser...
    Open browser    ${siteurl}  ${testbrowser}
    Maximize browser window
Input Username
    [Arguments]     ${username}
    Log to Console  Inputting username...
    Input text      ${field_username}   ${username}
    Log to Console  Username:${username} inputted.
Input Forgot Password Username
    [Arguments]     ${username}
    Log to Console  Inputting username...
    Input text      ${field_fpusername}     ${username}
    Log to Console  Username:${username} inputted.
Input Password
    [Arguments]     ${password}
    Log to Console  Inputting password...
    Input text      ${field_password}   ${password}
    Log to Console  Password Inputted.
Un/Hide Password
    Log to Console  Checking password input...
    Click element   ${icon_private}
    Click element   ${icon_private}
Click Login
    Click element   ${btn_login}
    Log to Console  Waiting to Login...
Verify Admin Login
    Wait Until Element Is Visible   ${companies}    60s
    Log to Console  Companies are displayed...
Verify Login Success
    Wait Until Element Is Visible   ${scorecard}    60s
    Log to Console  User logged in successfully
Verify Error Message
    Wait Until Element Is Visible   ${error_msg}    60s
    Log to Console  Error message is displayed
Verify Reset Error Message
    Wait Until Element Is Visible   ${reset_error_msg}      60s
    Log to Console  Error message is displayed
Logout Admin
    Wait Until Element is Visible   ${admin_profile}    60s
    Log to Console  Click User Profile dropdown
    Click element   ${admin_profile}
    Log to Console  Select Logout
    Click element   ${logout_btn}
    Wait Until Element is Visible   ${login_form}       10s
    Log to Console  Admin Logged out
Logout
    Wait Until Element is Visible   ${user_profile}     10s
    Log to Console  Click User Profile dropdown
    Click element   ${user_profile}
    Log to Console  Select Logout
    Click element   ${logout_btn}
    Wait Until Element is Visible   ${login_form}       10s
    Log to Console  User Logged out