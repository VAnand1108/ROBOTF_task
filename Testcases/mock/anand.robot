*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Library    RPA.Excel.Files

*** Variables ***
${ur;}    https://docs.telerik.com/devtools/winforms/api/telerik.wincontrols
${browser}    chrome
${attribute}    innerText
${Products-Menu}    //button[@type="button"]/ancestor::ul[@class="TK-Products-Menu"]
${title}    //div[@class="TK-col-18"]//div[@class="TK-col-8"]/h5
${title_dy}    (//div[@class="TK-col-18"]//div[@class="TK-col-8"]/h5)[{index}]

${inner_links}    ((//div[@class="TK-col-18"]//div[@class="TK-col-8"]/h5)[{index}]/following::div)[1]/a
${inner_links_dy}    (((//div[@class="TK-col-18"]//div[@class="TK-col-8"]/h5)[{index}]/following::div)[1]/a)[{index2}]



*** Keywords ***
sample
    Open Browser    ${ur;}    ${browser}
    Maximize Browser Window
    Sleep    3
    Wait Until Page Contains Element    ${Products-Menu}
    Mouse Over    ${Products-Menu}
    Wait Until Page Contains Element    ${title}
    ${h_count}    Get Element Count    ${title}

    Create Workbook        Testcases/mock/data1.xlsx

    ${output}    Create Dictionary
    FOR    ${counter}    IN RANGE    1     ${h_count}
        ${formatted_heading}    Format String    ${title_dy}    index=${counter}
        ${base_heading}    Get Element Attribute    ${formatted_heading}    ${attribute}

        ${base_h}    Format String    ${inner_links}    index=${counter}
        ${p_count}    Get Element Count    ${base_h}

        ${inner_list_cnt}    Create List
        FOR    ${count1}    IN RANGE    1    ${p_count}+1   
            
            ${formatted_datas}    Format String    ${inner_links_dy}    index=${counter}    index2=${count1}
            ${innerdata}    Get Element Attribute    ${formatted_datas}    ${attribute}

            Append To List       ${inner_list_cnt}      ${innerdata}   
        END

        Set To Dictionary    ${output}        title=${base_heading}    values=${inner_list_cnt} 
        Append Rows To Worksheet    ${output}     header=true
    END
    Save Workbook
    Close Workbook

    Log    ${output}

*** Test Cases ***
sampe1
    sample