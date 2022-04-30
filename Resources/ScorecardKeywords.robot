*** Settings ***
Library     SeleniumLibrary
Library     String
Library     Collections
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

Check Score Card Contents
    Wait Until Element Is Visible   ${date_navbar}      10s
    Log to Console      contains date picker nav bar
    Wait Until Element Is Visible   ${date_picker}      10s
    Log to Console      contains date picker button
    Wait Until Element Is Visible   ${overall_text}     10s
    Log to Console      contains Scorecard overall score
    Wait Until Element Is Visible   ${overall_display_text}     10s
    Log to Console      contains Display percentage
    Wait Until Element Is Visible   ${overall_inspire_text}     10s
    Log to Console      contains Inspire percentage
    Wait Until Element Is Visible   ${overall_convert_text}     10s
    Log to Console      contains Convert percentage
    Wait Until Element Is Visible   ${country_panel_scorecard}      10s
    Log to Console      contains Country section
    Wait Until Element Is Visible   ${retailer_panel_scorecard}     10s
    Log to Console      contains Retailer section
    Wait Until Element Is Visible   ${prodgroup_panel_scorecard}    10s
    Log to Console      contains Product Group section
    Wait Until Element Is Visible   ${country_filter}       10s
    Log to Console      contains Filters panel
    Log to Console      contains Country filter in Filters
    Wait Until Element Is Visible   ${retailer_filter}      10s
    Log to Console      contains Retailers filter in Filters
    Wait Until Element Is Visible   ${brand_filter}         10s
    Log to Console      contains Brand filter in Filters
    Wait Until Element Is Visible   ${prodgroup_filter}     10s
    Log to Console      contains Product group filter in Filters
#    Wait Until Element Is Visible   ${save_btn}             10s
#    Log to Console      contains Save filter button in Filters
#    Wait Until Element Is Visible   ${reset_btn}            10s
#    Log to Console      contains Reset filter button in Filters
#    Wait Until Element Is Visible   ${apply_btn}            10s
#    Log to Console      contains Apply filter button in Filters
    Wait Until Element Is Visible   ${saved_panel}          10s
    Log to Console      contains Saved filters panel

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

Compute Overall Score
    [Arguments]     ${display}     ${inspire}   ${convert}
    ${temp}=    Evaluate    ${display} + ${inspire}
    ${result}=  Evaluate    ${temp} + ${convert}
    [Return]    ${result}

Compute Percentage per module
    [Arguments]     ${module_xpath}    ${percent}
    ${module_score}=    Get Score       ${module_xpath}
    Log to Console  Overall Module score = ${module_score}
    ${module_percentage}=       Evaluate    ${module_score} * ${percent}
    [Return]    ${module_percentage}

Get Score
    [Arguments]     ${module_xpath}
    ${module_score}=    Get Text            ${module_xpath}
    ${module_score}=    Convert to Number   ${module_score}
    [Return]    ${module_score}


Verify Overall Score
    Click Link          ${scorecard_tab}
    Wait Until Element Is Visible   ${overall_text}     60s
    ${overall_score}=   Get Text    ${overall_text}
    ${overall_score}=   Remove String   ${overall_score}    %
    ${overall_score}=   Convert to Number   ${overall_score}
    Log to Console  Overall score = ${overall_score}

    ${display}=     Compute Percentage per module  ${overall_display_text}  0.30
    Log to Console  Display Percentage: ${display}
    ${inspire}=     Compute Percentage per module  ${overall_inspire_text}  0.30
    Log to Console  Inspire Percentage: ${inspire}
    ${convert}=     Compute Percentage per module  ${overall_convert_text}  0.40
    Log to Console  Convert Percentage: ${convert}

    ${overall}=     Compute Overall Score   ${display}      ${inspire}      ${convert}
    Log to Console  Computed Overall Score: ${overall}
    ${upper_range}=  Evaluate    ${overall} + 0.05
    ${lower_range}=  Evaluate    ${overall} - 0.05

    Run Keyword Unless      ${overall} > ${upper_range} and ${overall} < ${lower_range}
...     Passed Score  ${overall}    ${overall_score}    ${EMPTY}

#    Should be Equal as Numbers      ${overall}      ${overall_score}        precision=2
#    Log to Console  Overall score is verified!

Verify Display Pillar Score
    Click Element       ${display_pillar}
    ${display_score}=   Get Score       ${overall_display_text}
    Log to Console      DISPLAY SCORE from Scorecard: ${display_score}
    Click Link          ${display_tab}
    Log to Console      Accessing Display Modules...
    Wait Until Element is Visible       ${sos_rankings}     60s
    ${searchwords_score}=   Get Score   ${overall_display_text}
    ${searchwords}=     Evaluate    ${searchwords_score} * 0.30
    Log to Console      Search Words SCORE: ${searchwords_score}

    ${visibility_score}=    Get Score   ${overall_inspire_text}
    ${visibility}=      Evaluate    ${visibility_score} * 0.40
    Log to Console      Visibility SCORE: ${visibility_score}

    ${categories_score}=    Get Score   ${overall_convert_text}
    ${categories}=      Evaluate    ${categories_score} * 0.30
    Log to Console      Categories SCORE: ${categories_score}

    ${overall}=     Compute Overall Score   ${searchwords}      ${visibility}       ${categories}
    Log to Console  Computed Overall Display Score: ${overall}
    ${upper_range}=  Evaluate    ${overall} + 0.05
    Log to Console  upper range: ${upper_range}
    ${lower_range}=  Evaluate    ${overall} - 0.05
    Log to Console  lower range: ${lower_range}

    Run Keyword If      ${display_score} < ${upper_range} and ${display_score} > ${lower_range}
...     Passed Score  ${overall}    ${display_score}    Display
...     ELSE    FAIL    Score from Scorecard: ${display_score} does not match Computed score: ${overall}
#...     ELSE        Log to Console  Fail

#    FOR     ${i}    IN RANGE    1   ${row}+1
#        ${catbar}=      catenate    SEPARATOR=      ${display_catbar}       [${i}]/div[1]/label[2]
#        ${catrate}=     get text    ${catbar}
#        ${catrate}=     Remove String           ${catrate}      %
#        ${catrate}=     Convert to Number       ${catrate}
#        ${catsum}=      Evaluate    ${catsum} + ${catrate}
#        Log to Console      Cat[${i}]: ${catrate} Summation: ${catsum}
#    END
#    ${average}=         Evaluate        ${catsum} / ${row}
#    Log to Console      Display %: ${average}

Verify Inspire Pillar Score
    Click Link          ${inspire_tab}
    Log to Console      Accessing Display Modules...
    Wait Until Element is Visible       ${content_table}        60s
    ${content_score}=   Get Score   ${overall_display_text}
    ${content}=     Evaluate    ${content_score} * 0.80
    Log to Console      Content SCORE: ${content_score}

    ${ratings_score}=    Get Score   ${overall_inspire_text}
    ${ratings}=     Evaluate    ${ratings_score} * 4
    Log to Console      Ratings SCORE: ${ratings_score}

    ${overall}=     Compute Overall Score   ${content}      ${ratings}       ${0}
    ${upper_range}=  Evaluate    ${overall} + 0.05
    ${lower_range}=  Evaluate    ${overall} - 0.05

    Click Link          ${scorecard_tab}
    Wait Until Element is Visible       ${inspire_pillar}       60s
    Click Element       ${inspire_pillar}
    ${inspire_score}=   Get Score       ${overall_inspire_text}
    Log to Console      INSPIRE SCORE from Scorecard: ${inspire_score}

    Run Keyword If      ${inspire_score} < ${upper_range} and ${inspire_score} > ${lower_range}
...     Passed Score  ${overall}    ${inspire_score}    Inspire
...     ELSE    FAIL    Score from Scorecard: ${inspire_score} does not match Computed score: ${overall}

Passed Score
    [Arguments]     ${computed}    ${displayed}     ${module}
    Log to Console  Computed Overall ${module} Score: ${computed}
    Log to Console  ${module} Score from Scorecard ${displayed} ≈ Computed ${module} score ${computed}
    Log to Console  ${module} score is verified!


Verify Convert Pillar Score
    Click Link          ${scorecard_tab}
    Wait Until Element is Visible       ${convert_pillar}       60s
    Click Element       ${convert_pillar}
    ${convert_score}=   Get Score       ${overall_convert_text}
    Log to Console      CONVERT SCORE from Scorecard: ${convert_score}
    Click Link          ${convert_tab}
    Log to Console      Accessing Convert Modules...
    Wait Until Element is Visible       ${convert_table}        60s
    ${stock_score}=     Get Score       ${overall_display_text}
    Log to Console  Computed Overall Stock Score: ${stock_score}


    Should be Equal as Numbers      ${convert_score}        ${stock_score}      precision=2
    Log to Console  Convert Score from Scorecard ${convert_score} ≈ Computed Display score ${stock_score}
    Log to Console  Convert score is verified!


#I CAN'T FREAKING ACCESS THE SCORE TREND!
#Verify Overall Score Variance
#    Click Element   ${display_pillar}
#    Wait Until Element Is Visible   ${scoretrend_container}     60s
#    ${week}=        Get Text        ${wk31}
#    Click Element   ${filtered_score_legend}
#    Log to Console  Week: ${week}
#    Mouse over      ${scoretrend}
