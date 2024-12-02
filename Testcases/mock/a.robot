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

${str}    2021

*** Keywords ***
Extract Sections and Links
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Sleep    3
    
    ${no_of_title}    Get Element Count    ${para} 
    ${output dic}    Create Dictionary
    FOR    ${counter}    IN RANGE    1    ${no_of_title}+1
        ${formatted_t_xpath}    Format String    ${title_dy}    index=${counter}
        ${tile_list}    Get Element Attribute    ${formatted_t_xpath}     ${ATTRIBUTE}
        
        ${formatted_p_xpath}    Format String    ${para_dy}    index=${counter}
        ${section_list}    Get Element Attribute    ${formatted_p_xpath}     ${ATTRIBUTE}

        Set To Dictionary     ${output dic}     ${tile_list}=${section_list}
        
    END
    Log     ${output dic} 


*** Test Cases ***
Extract and Log Section Data
    Extract Sections and Links
