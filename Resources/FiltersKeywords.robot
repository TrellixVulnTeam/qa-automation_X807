*** Settings ***
Library     SeleniumLibrary
Library     String
Variables   ../PageObjects/Locators.py
Resource    LoginKeywords.robot

*** Keywords ***
Login to App
    [Arguments]     ${username}     ${password}
    Input Username  ${username}
    Log to console  Username entered.
    Input Password  ${password}
    Log to console  Password entered.
    Click Login
    Verify Login Success

Check Date filter
    Wait Until Element Is Visible   ${date_navbar}      15s
    Log to Console      contains date picker nav bar
    Wait Until Element Is Visible   ${date_picker}      15s
    Log to Console      contains date picker button
    Check calendar
    Check month slider
    Check year slider

Check Panel Scores
    Wait Until Element Is Visible   ${country_panel_scorecard}      15s
    Log to Console      contains Country section
    Wait Until Element Is Visible   ${retailer_panel_scorecard}     15s
    Log to Console      contains Retailer section
    Wait Until Element Is Visible   ${prodgroup_panel_scorecard}    15s
    Log to Console      contains Product Group section
    Wait Until Element Is Visible   ${country_filter}       15s
    Log to Console      contains Filters panel
    Log to Console      contains Country filter in Filters
    Wait Until Element Is Visible   ${retailer_filter}      15s
    Log to Console      contains Retailers filter in Filters
    Wait Until Element Is Visible   ${brand_filter}         15s
    Log to Console      contains Brand filter in Filters
    Wait Until Element Is Visible   ${cat_filter}           15s
    Log to Console      contains Product group filter in Filters
    Wait Until Element Is Visible   ${save_btn}             15s
    Log to Console      contains Save filter button in Filters
    Wait Until Element Is Visible   ${reset_btn}            15s
    Log to Console      contains Reset filter button in Filters
    Wait Until Element Is Visible   ${apply_btn}            15s
    Log to Console      contains Apply filter button in Filters
    Wait Until Element Is Visible   ${saved_panel}          15s
    Log to Console      contains Saved filters panel

Check Overall Pillars
    Wait Until Element Is Visible   ${overall_text}     15s
    Log to Console      contains Scorecard overall score
    Wait Until Element Is Visible   ${overall_display_text}     15s
    Log to Console      contains Display percentage
    Wait Until Element Is Visible   ${overall_inspire_text}     15s
    Log to Console      contains Inspire percentage
    Wait Until Element Is Visible   ${overall_convert_text}     15s
    Log to Console      contains Convert percentage
    Wait Until Element Is Visible   ${worldmap_rect}    15s
    Log to Console      contains world map

Check calendar
    Click Element   ${date_picker}
    Log to Console  Calendar is Visible
    Click Element   ${date_picker}

Check month slider
    Click Element   ${date_picker}
    Wait Until Element is Visible   ${next_month_slider}    60s
    ${curr}=    get text    ${month_selection}
    Log to Console  Current Month: ${curr}
    Click Element   ${next_month_slider}
    ${next}=    get text    ${month_selection}
    Log to Console  Next Month: ${next}
    Click Element   ${prev_month_slider}
    Click Element   ${prev_month_slider}
    ${prev}=    get text    ${month_selection}
    Log to Console  Previous Month: ${prev}

Check year slider
    Click Element   ${date_picker}
    Wait Until Element is Visible   ${next_year_slider}     60s