*** Settings ***
Library    SeleniumLibrary
Library    builtin
Library    String
Library    Collections
Variables    ../../Datas/data.py
Variables    ../../Datas/xpath.py
Resource    ../../Testcases/Task1/Tc01.robot



*** Keywords ***
open the amazon app
    [Documentation]    Launch the Application
    [Arguments]       ${url}    ${browser}
    Open Browser    ${amazon_url}    ${browser}
    Maximize Browser Window
    Sleep    5
searching the amazon product
    [Documentation]    Input the 5g in the search box and select the 5G under 10000
        
    Wait Until Page Contains Element    ${amazon_title}
    Input Text    ${searchbar}    ${user_text}
    Capture Page Screenshot
    Wait Until Page Contains Element    ${mobile_search}
    Click Element    ${mobile_search}
    Capture Page Screenshot


Get Mobile Details

    [Documentation]    Count the Product and Log the products under 10k and sponsered Tag.

    ${mobile_count}    Get Element Count    ${phone_card}
    Log    Total Mobiles Found: ${mobile_count}
    ${output_format_list}    Create List
    FOR    ${counter}    IN RANGE    1    ${mobile_count}+1
        ${phone_container_element}    Format String    ${phone_card_dynamic}    count=${counter}
        ${text}    Get Element Attribute    ${phone_container_element}    innerText
        ${status}    Run Keyword And Return Status    Should Not Contain    ${text}    ${sponsored}
        IF    ${status} == True
            ${price}    Get Mobile Price    ${counter}
            ${price}    Replace String    ${price}    ${commas}    ${EMPTY}
            ${price}    Replace String    ${price}    ${dollar}    ${EMPTY}
            ${price}    Convert To Integer    ${price}
            IF    ${price} < ${price_limit}
                ${name}    Get Mobile Name    ${counter}
                ${output_format}    Catenate    ${name} -> ${price}
                Append To List    ${output_format_list}    ${output_format}
            END
        ELSE
            Log    This Mobile is Sponsored and will be skipped.
        END
    END
    Log    ${output_format_list}

Get Mobile Price
    [Arguments]    ${counter}
    ${price_element}    Format String    ${phone_price_dynamic}    count=${counter}
    ${price}    Get Element Attribute    ${price_element}    ${Attribute}
    [Return]    ${price}

Get Mobile Name
    [Arguments]    ${counter}
    ${name_element}    Format String    ${phone_name_dynamic}    count=${counter}
    Wait Until Element Is Visible    ${name_element}
    Scroll Element Into View    ${name_element}
    ${name}    Get Text    ${name_element}
    [Return]    ${name}
