*** Settings ***
Library     SeleniumLibrary
Library     String
Resource    ../Resources/LoginKeywords.robot
# chromedrive path : C:\Users\my User Folder\AppData\Local\Programs\Python\Python38\Scripts

#Suite Setup runs only once. headlesschrome is used to run in the background
Suite Setup     Launch Browser      ${url}      ${browser}      #headlesschrome
#Suite Teardown happens at the very end of execution
Suite Teardown  Close All Browsers

# Test Setup and Teardown runs for every test case
Test Setup      Setup Properties
Test Teardown   Teardown Properties

*** Variables ***
${browser}  chrome
${url}      https://accounts.detailonline.com/
${mailinator}       https://www.mailinator.com/
${gmail}    https://mail.google.com/
${admin}    issa.david@detailonline.tech
${admin_pass}       Packages1
${owner}    msprice-own@mailinator.com
${owner_pass}       d3t@1l@dm1n
${normal}   msprice-normal@mailinator.com
${normal_pass}      d3t@1l@dm1n

${invalidemail}     admin123
${incorrectemail}   admin123@detailonline.com
${invalidpassword}  admin123password

*** Test Cases ***
7.0 Login - Login using correct credentials
    [Tags]  correct
    Log to console  Input correct email address
    Input Username  ${owner}
    Log to console  Input correct password
    Input Password  ${owner_pass}
    Log to Console  Select password seeker on login form
    Un/Hide Password
    Log to Console  Select login button
    Click Login
    Verify Login Success
    Logout
7.0 Login - Login using incorrect credentials
    [Tags]  incorrect
    Log to console  Input incorrect email address
    Input Username  ${incorrectemail}
    Log to console  Input correct password
    Input Password  ${invalidpassword}
    Log to Console  Select password seeker on login form
    Un/Hide Password
    Log to Console  Select login button
    Click Login
    Verify Error Message    #Invalid email or password​
7.0 Login - Login using incorrect email address/correct password
    [Tags]  incorrect
    Log to console  Input incorrect email address
    Input Username  ${incorrectemail}
    Log to console  Input correct password
    Input Password  ${admin_pass}
    Log to Console  Select password seeker on login form
    Un/Hide Password
    Log to Console  Select login button
    Click Login
    Verify Error Message
7.0 Login- Verify Redirect page after login using Admin Acct
    [Tags]  admin
    Log to console  Input correct email address
    Input Username  ${admin}
    Log to console  Input correct password
    Input Password  ${admin_pass}
    Un/Hide Password
    Click Login
    Verify Admin Login
    Logout Admin
7.0 Login- Verify Redirect page after login using Owner Acct
    [Tags]  owner
    Log to console  Input correct email address
    Input Username  ${owner}
    Log to console  Input correct password
    Input Password  ${owner_pass}
    Un/Hide Password
    Click Login
    Verify Login Success
    Logout
7.0 Login- Verify Redirect page after login using Normal user Acct
    [Tags]  normal
    Log to console  Input correct email address
    Input Username  ${normal}
    Log to console  Input correct password
    Input Password  ${normal_pass}
    Un/Hide Password
    Click Login
    Verify Login Success
    Logout
7.0 Login - Forgot Password: Enter invalid address
    [Tags]  forgot
    Log to Console      Click "Forgot password" functionality
    Click Link          Forgot your password?
    Log to Console      Input invalid email address
    Input Forgot Password Username      ${invalidemail}
    Wait Until Element is Visible       ${reset_error_msg}      60s
    Log to Console      Click "Reset Password" button
    Click element       ${btn_reset}
    Log to Console      Error message should appear
7.0 Login - Forgot Password: Enter valid address
    [Tags]  forgot
    Go Back
    Log to Console      Click "Forgot password" functionality
    Click Link          Forgot your password?
    Log to Console      Input valid email address
    Input Forgot Password Username      ${normal}
    Log to Console      Click "Reset Password" button
    Click element       ${btn_reset}
    Wait Until Element is Visible       ${prompt_reset}     60s
7.0 Login - Forgot Password: Check reset password email
    [Tags]  forgot
    Launch Browser      ${mailinator}       ${browser}
#    Launch Browser      ${gmail}        ${browser}
    ${head}=        get title
    Log to Console  ${head}
#    Wait Until Element is Visible       ${gmail_input}     10s
    ${testuser}=    Remove String       ${normal}       @mailinator.com
    Log to Console  ${testuser}
    Wait Until Element is Visible       ${public_mail}  10s
    Input text      ${public_mail}      ${testuser}
    Click element   ${go_generate}
    Wait Until Element is Visible       ${public_inbox}     15s
    Log to Console  Opening ${testuser} inbox...
    Wait Until Element is Visible       ${notif_sender}     15s
    Element Text Should Be      ${notif_sender}     support@detailonline.com
    ${sender}=      Get Text        ${notif_sender}
    Log to Console  Message from ${sender}...
    Wait Until Element is Visible       ${notif_title}      15s
    Element Text Should Be      ${notif_title}      Detail Online - Password Reset
    ${title}=       Get Text        ${notif_title}
    Log to Console  Subject of email is ${title}...
    Click element   ${notif_title}
    Wait Until Element is Visible      ${mail_body}        15s
    Execute javascript  window.scrollTo(0,document.querySelector("html").scrollHeight)
    Log to Console  Scrolled to bottom

*** Keywords ***
Setup Properties
    Set Selenium Speed  2s
    Set Selenium Timeout  60s
Browser Properties
    Launch Browser      ${url}      headlesschrome      #${browser}
Teardown Properties
    Sleep   5s
