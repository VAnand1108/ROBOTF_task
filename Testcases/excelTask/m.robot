*** Settings ***
Library    SeleniumLibrary
# Variables    data.py

*** Variables ***


${url}     https://www.browserstack.com/home?utm_source
${prod_button}      //*[@id="products-dd-toggle"]
${prod_panel1}     css=#products-dd-tabpanel-1
${prod_panel2}      "id=products-dd-tabpanel-2"
${web_test_btn}     (//*[contains(@class,'bstack-mm-sub-nav-tab')])[1]
${app_test_btn}     "(//*[contains(@class,'bstack-mm-sub-nav-tab')])[2]"




*** Keywords ***
Open Page
    Open Browser    ${url}    chrome
    Maximize Browser Window

Hover Product Tab 
    Mouse Over    ${prod_button}

Hover Web Testing1
    Mouse Over    ${web_test_btn}

Hover App Testing2
    Mouse Over    ${app_test_btn}

Check Word Exists1    [Arguments]    ${word}
    Element Should Contain    ${prod_panel1}    ${word}
    
Check Word Exists2    [Arguments]    ${word}
    Element Should Contain    ${prod_panel2}    ${word}  

Click the Link    [Arguments]    ${word}
    ${Ele}    Get WebElements    //div[@class=" bstack-mm-sub-nav-tabcol"][2]/child::div/a/span[contains(text(),'${word}')]    
    FOR    ${element}    IN    @{Ele}
        Click Element    ${element}
        Go Back
        Hover Product Tab
        Hover Web Testing1    
        # Hover App Testing2
    END
    

*** Test Cases ***
Test1
    # Set Selenium Speed    0.5
    # Set Selenium Implicit Wait    10
    Open Page
    Hover Product Tab
    Hover Web Testing1    
    Check Word Exists1    ${WORD}
    Hover App Testing2    
    Check Word Exists2    ${WORD}
    # Click the Link    ${WORD}