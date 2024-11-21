*** Settings ***
*** Settings ***
Library    SeleniumLibrary
Library    builtin
Library    String
Library    Collections
Variables    ../../Datas/data.py
Variables    ../../Datas/xpath.py
Resource    ../../Testcases/Task1/TC01_support.robot


*** Keywords ***
open the amazon app
    [Documentation]    Launch the Application
    # [Arguments]       ${url}    ${browser}
    Open Browser    ${amazon_url}    ${browser}
    Maximize Browser Window
    Sleep    5

Open Amazon And Search for IPhone and Sort By Highest Prices

    Wait Until Page Contains Element    ${searchbar}
    Input Text    ${searchbar}    ${product_name_i}
    Press Keys    ${searchbar}    RETURN
    Capture Page Screenshot
    Click Element    ${sort_by}
    Click Element    ${high_to_low}

# Add 10 Mobiles Name And Prices To List
    ${Name_List}    Create List
    ${Price_List}    Create List
    Wait Until Element Is Visible    ${search_div}
    FOR    ${count}    IN RANGE    1    11
        ${Element}    Format String    ${phone_name}    count=${count}
        Wait Until Element Is Visible    ${Element}
        ${P_name}    Get Text    ${Element}
        Append To List    ${Name_List}    ${P_name}
        ${Element}    Format String    ${phone_price}    count=${count}
        ${P_price}    Get Element Attribute    ${Element}    innerText
        Append To List    ${Price_List}    ${P_price}  
    END
    Log    ${Name_List}
    Log    ${Price_List}
 

*** Test Cases ***

tc02
    Given open the amazon app    
    When Open Amazon And Search for IPhone and Sort By Highest Prices
    # Then Add 10 Mobiles Name And Prices To List
