*** Settings ***
Library    SeleniumLibrary
Library    builtin
Library    String
Library    Collections
Variables    ../../Datas/data.py
Variables    ../../Datas/xpath.py



*** Keywords ***

Open BrowserStack Website
    Open Browser    ${browser_url}    ${browser}
    Maximize Browser Window
    Sleep    5
Navigate To Pricing
    Wait Until Page Contains Element    ${pricing_menu}    
    Click Element    ${pricing_menu}
    Capture Page Screenshot
    Wait Until Element Is Visible    ${team_tab}    timeout=5
    Capture Page Screenshot
Get Pricing For Different Users 
    ${list_count}    Get Element Count    ${user_dropdown}

    ${user_price_dict}    Create Dictionary

    FOR    ${counter}    IN RANGE    1    ${list_count}+1
        
        Click Element    ${team_tab}
        Wait Until Element Is Visible    ${user_dropdown}    timeout=5
        ${user_count_xpath}    Format String    ${user_dropdown_list_template}    user_num=${counter}
        ${users}    Get Text    ${user_count_xpath}
        Wait Until Element Is Visible    ${user_count_xpath}
        Click Element    ${user_count_xpath}
        Sleep    2    
        ${price}    Get Text    ${price_text}
        Capture Page Screenshot
        Set To Dictionary    ${user_price_dict}    ${users}     ${price}
    END

    Log    ${user_price_dict}
