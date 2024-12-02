*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Library    RPA.Excel.Files

*** Variables ***
${URL}                     https://www.telerik.com/support/whats-new/winforms/release-history
${BROWSER}                 chrome
${ATTRIBUTE}               innerText
${title}    //ul[@class="List Space--streched"]//a
${title_dy}    (//ul[@class="List Space--streched"]//a)[{index}]

${para}    (//ul[@class="List Space--streched"]//p[contains(text(),'2021')])
${para_dy}    (//ul[@class="List Space--streched"]//p[contains(text(),'2021')])[{index}]
${excel_path}    Testcases/mock/data.xlsx

*** Keywords ***
Extract Sections and Links
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Sleep    3
    
    # Create Workbook        Testcases/mock/data.xlsx

    ${no_of_title}    Get Element Count    ${para} 
    ${output dic}    Create Dictionary
    ${output_list}    Create List
    FOR    ${counter}    IN RANGE    1    ${no_of_title}+1
        ${formatted_t_xpath}    Format String    ${title_dy}    index=${counter}
        ${tile_list}    Get Element Attribute    ${formatted_t_xpath}     ${ATTRIBUTE}
        
        ${formatted_p_xpath}    Format String    ${para_dy}    index=${counter}
        ${section_list}    Get Element Attribute    ${formatted_p_xpath}     ${ATTRIBUTE}
        &{row}=    Create Dictionary
        ...        Title    ${tile_list}
        ...        Section    ${section_list}
        Append To List    ${output_list}    ${row}
        Set To Dictionary     ${output dic}     ${tile_list}=${section_list}
        
    END
    Log     ${output dic} 
    # Write Data To Excel    ${output dic}    ${excel_path}
    Write Data To Excel    ${output_list}    file_path=${excel_path}
Write Data To Excel
    [Arguments]    ${data}    ${file_path}
    Create Workbook  ${excel_path}
    FOR    ${index}    ${element}    IN ENUMERATE    @{data}
        Append Rows to Worksheet  ${element}  header=${TRUE}    
    END     
    
    Save Workbook
    Close Workbook
*** Test Cases ***
Excel
    Extract Sections and Links
