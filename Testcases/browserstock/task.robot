*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections


*** Variables ***

${url}    https://www.browserstack.com/
${browser}    chrome
${attribute}   title
${title_price}    //a[@title="Pricing"]
${title_tabs}  //div[@id='sidenav__list']//a[not(contains(@data-family,'app_testing')) or contains(@data-family,"web_and_app_testing")]
${title_tabs_dy}    (//div[@id='sidenav__list']//a[not(contains(@data-family,'app_testing')) or contains(@data-family,"web_and_app_testing")])[{index}]

*** Keywords ***
launch the browser
    Open Browser    ${url}    ${browser}
    Maximize Browser Window


navigate to browser stack and click on price 
    

    Wait Until Page Contains Element    ${title_price}
    Click Element    ${title_price}
    ${side_title_list}    Create List
    ${title_tab_name}    Get Element Count    ${title_tabs}

    FOR    ${counter}    IN RANGE    1    ${title_tab_name}+1
        
        ${formated_title_xpath}    Format String      ${title_tabs_dy}     index=${counter}
        Click Element    ${formated_title_xpath}
        Capture Page Screenshot
        ${title}    Get Element Attribute    ${formated_title_xpath}    ${attribute}

        Append To List    ${side_title_list}     ${title}

        
    END
    Log    ${side_title_list}


*** Test Cases ***
browserstock    
    launch the browser
    navigate to browser stack and click on price