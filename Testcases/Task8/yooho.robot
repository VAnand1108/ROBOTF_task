*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Library    RPA.Excel.Files


*** Variables ***
${url}    https://news.google.com/home?hl=en-IN&gl=IN&ceid=IN:en
${browser}    chrome
${arrow_btn}     //div[contains(text(),'Chennai')]//ancestor::div[@class="dSBEqc"]/button
${count_of_arrow}    //div[@class="qN9IM"]/div
${count_of_arr_dy}    (//div[@id="c235"]/div)[{index}]
${Attribute}    innerText
${Attribute1}    Fill
${left-arrow}    //div[contains(text(),'Chennai')]//ancestor::div[@class="dSBEqc"]/button
${date}    (//div[@class="qN9IM"]/div/div[@class="Hmgqjd"])[{index}]
${temp}    (//div[@class="qN9IM"]/div/div[@class="mY96Db"])[{counts}]
${rain}     (//div[contains(@aria-label,'{name}')]/div/span/*[@xmlns='http://www.w3.org/2000/svg']/*/*[@style='mix-blend-mode: multiply; display: block;']/*[@opacity='1']/*[@fill-opacity='1'])[1]
${color_check}    rgb(66,133,244)

*** Keywords ***

open the application
    Open Browser    ${url}    ${browser}    ${OPTIONS}=add_argument("--incognito")
    Maximize Browser Window
    create Workbook    Testcases/Task8/data.xlsx   sheet_name=Sheet1
    Wait Until Element Is Visible    ${arrow_btn}    
    Click Element    ${arrow_btn}

    ${dict}    Create Dictionary
    ${count f_arrow}    Get Element Count    ${count_of_arrow}
    
    FOR    ${counter}    IN RANGE    1    ${count f_arrow}+1    
        Sleep    3
        ${get_date}    Format String    ${date}    index=${counter}
        ${element_date}    Get Element Attribute    ${get_date}    ${Attribute}
        ${get_temp}    Format String    ${temp}    counts=${counter}
        ${element_temp}    Get Element Attribute    ${get_temp}    ${Attribute}
        ${F_date}    Format String    ${rain}    name=${element_date}

        ${color}    Run Keyword And Return Status    Get Element Attribute    ${F_date}    ${Attribute1}
        IF    $color == $True
            ${colors}    Get Element Attribute    ${F_date}    ${Attribute1}
            IF    $colors == $color_check
                ${get_color}    Set Variable    Rain
           
            END
        ELSE
                ${get_color}    Set Variable    drizzling        
        END
        Set To Dictionary    ${dict}    DAY=${element_date}    TEMP=${element_temp}    Whether=${get_color}
        Append Rows To Worksheet    ${dict}    header=${True}
       
    END
    Save Workbook

*** Test Cases ***
tc01
    open the application



 
 