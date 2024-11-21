*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Library    RPA.Excel.Files

Variables    ../../Testcases/Task8/xpath.py

*** Keywords ***

launch the browser
    Open Browser    ${url}    ${browser}    OPTIONS=argument(--incognito)
    Maximize Browser Window
    Sleep    3

get page title and Text
    Create Workbook    Testcases/Task8/data.xlsx   sheet_name=Sheet1

    Wait Until Page Contains Element    ${manage_acc}
    Click Element    ${manage_acc}
    number of page
    Save Workbook

number of page 
    ${dict}    Create Dictionary

    ${element_count}    Get Element Count    ${count}
    FOR    ${counter}    IN RANGE    1    ${element_count}+1  
        ${Tittle}    Format String    ${title_name}    index=${counter}
        ${title1}    Get Element Attribute    ${Tittle}    ${Attribute}
        ${content}    Format String    ${text}    name=${counter}
        ${new_content}    Get Element Attribute    ${content}    ${Attribute}
        Set To Dictionary    ${dict}    Title=${title1}    Content=${new_content}

        Append Rows To Worksheet    ${dict}    header=${True}
        IF    $element_count == $counter
            ${next_page_status}    Run Keyword And Return Status    Click Element    ${next_page}
            IF    ${next_page_status} == True
                number of page
            END
        END
    END


navigate to next page 
    Click Element    ${prev_page}
    Get Change Text in Title and click the title  

Get Change Text in Title and click the title  
    ${title_count}    Get Element Count    ${get_change_in_title}
    FOR    ${counter}    IN RANGE    1    ${title_count}
        ${click_title}    Format String    ${change_in_title_dy}    titles=${counter}
        Wait Until Page Contains Element    ${click_title}
        Click Element    ${click_title}
        Wait Until Page Contains Element   ${help_center}
        Click Element    ${help_center}
        IF    $title_count == $counter
            ${next_page_status}    Run Keyword And Return Status    Click Element    ${next_page}
            IF    $next_page_status == True
               Get Change Text in Title and click the title  
            END
        END
       
    END
 
 
 
*** Test Cases ***
TASK
    launch the browser
    get page title and Text  
    navigate to next page 
  
   Open Browser
   Close Browser
   Click Button    locator
   Click Element    locator
 
 