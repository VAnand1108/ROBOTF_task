*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String
Library    Process
Library    RPA.Excel.Files
Variables    ../../Testcases/Task7/data.py
# Variables    ../../Testcases/Task6/xpath.py




*** Keywords ***
launch the browser and click the Frame
    Open Browser    ${url}    ${browser}
    Maximize Browser Window
    Select Frame    ${iframe}
    Click Element    ${find_out_btn}
 
handling alert popups
    Wait Until Element Is Visible    ${alert_box}
    Element Should Be Visible    ${alert_box}
    Scroll Element Into View    ${close_btn}
    Set Focus To Element    ${close_btn}
    Press Keys    ${close_btn}    ENTER
 
handling image and validating the id present  
    Click Element    ${prod_btn}
    Wait Until Element Is Visible    ${products}
    ${products_count}    Get Element Count    ${products}
    FOR    ${count}    IN RANGE    1    ${products_count}+1
        ${Element}    Format String    ${prod_dynamic}    input=${count}
        Wait Until Element Is Visible    ${Element}
        Click Element    ${Element}
        Unselect Frame
        Select Frame    ${iframe}
        Wait Until Element Is Visible    ${prod_pop_up}
        Element Should Contain    ${prod_pop_up}    ${id}
        Wait Until Element Is Visible    ${close_btn}
        Click Element    ${close_btn}
    END



*** Test Cases ***
Task7

    launch the browser and click the Frame 
    handling alert popups
    handling image and validating the id present  
 