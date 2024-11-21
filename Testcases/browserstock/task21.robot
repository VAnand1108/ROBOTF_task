*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
 
*** Variables ***
${url}    https://www.browserstack.com/
${browser}    chrome
${price_btn}    //a[@title='Pricing']
${side_nav}    //div[@id='sidenav__list']//a[@data-family='web_testing' or @data-family='web_and_app_testing']
${side_nav_dyn}    (//div[@id='sidenav__list']//a[@data-family='web_testing' or @data-family='web_and_app_testing'])[{count}]
${header_path}    //div[@class='sidenav-content sidenav-content__active']//div[@data-mobile-view='false' and not(contains(@class,'enterprise'))]//div[contains(@class,'plan-name')]
${header_dynamic_path}    (//div[@class='sidenav-content sidenav-content__active']//div[@data-mobile-view='false' and not(contains(@class,'enterprise'))]//div[contains(@class,'plan-name')])[{count}]
${Free}    Free
${price_path}    ((//div[@class='sidenav-content sidenav-content__active']//div[@data-mobile-view='false' and not(contains(@class,'enterprise'))]//div[contains(@class,'plan-name') and contains(text(),'{text}')])[1]/following::span[@class='amount'])[1]
 
*** Test Cases ***
test03
    Open Browser    ${url}    ${browser}
    Maximize Browser Window
    Click Element    ${price_btn}
    ${dict}    Create Dictionary
    ${output_dict}    Create Dictionary
    ${title_count}    Get Element Count    ${side_nav}
    FOR    ${counter}    IN RANGE    1    ${title_count}+1
        ${element}    Format String    ${side_nav_dyn}    count=${counter}
        ${title}    Get Element Attribute    ${element}    title
        Click Element    ${element}
        Reload Page
        Wait Until Page Contains Element    ${header_path}    10
        ${heading_count}    Get Element Count    ${header_path}
        IF    $heading_count >= 2
            ${heading_count}    Set Variable    2
        END
        ${heading_list}    Create List
        FOR    ${cnt}    IN RANGE    1    ${heading_count}+1
            ${ele}    Format String    ${header_dynamic_path}    count=${cnt}    
            ${heading_text}    Get Element Attribute    ${ele}    innerText
            IF    '&' not in $heading_text
                ${heading_text}    Strip String    ${SPACE}${heading_text}${SPACE}
            END
            IF    $heading_text == $Free
                ${price_text}    Set Variable    None
            ELSE
                ${ele}    Format String    ${price_path}    text=${heading_text}
                ${status}    Run Keyword And Return Status    Wait Until Page Contains Element    ${ele}    
                IF    $status == True
                    ${price_text}        Get Element Attribute    ${ele}    innerText    
                ELSE
                    ${price_text}    Set Variable    None
                END
               
            END
            Append To List    ${heading_list}    ${heading_text}--->${price_text}                
        END
        Set To Dictionary    ${dict}    ${title}    ${heading_list}
    END
    Log    ${dict}
    # FOR    ${key}    IN    @{dict}
    #     ${val}    Get From Dictionary    ${dict}    ${key}
    #     Log    ${key} : ${val}        
    # END