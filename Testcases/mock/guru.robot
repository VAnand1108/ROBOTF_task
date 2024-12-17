*** Settings ***
Library    SeleniumLibrary


*** Variables ***
${url}   https://www.browserstack.com/customers?cs-industry=
${browser}    chrome 
${title}    //h2[text()="Customer stories"]
${Select_box_xpath}    //select[@name="cs-industry"]
${btn}    //button[@class="select-dropdown__button select-dropdown__button--selectIndustry"]


*** Keywords ***
browser dropdown list
    Open Browser    ${url}    ${browser}
    Maximize Browser Window
    Sleep    3
    Wait Until Page Contains Element    ${Select_box_xpath}
    
    Scroll Element Into View    //a[text()=" Get Started Free"]
    Sleep    3
    Scroll Element Into View    ${btn}
    Click Element    ${btn}
    Sleep    2
    # Select From List By Value    ${Select_box_xpath}     BFSI
    # Wait Until Page Contains    text
    Click Element    //li[@data-value="FMCG"]
    Capture Page Screenshot


*** Test Cases ***
Tc1
    browser dropdown list