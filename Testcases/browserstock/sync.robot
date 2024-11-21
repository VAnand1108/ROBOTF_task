*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Library    Screenshot
 
*** Variables ***
${url}    https://www.browserstack.com/
${browser}    chrome
${product}    //button[contains(text(),'Products')]
${web_testing}    //div[@id="products-dd-menu"]//button[@title="Web Testing"]/span    
${sub_menus}    (//div[@id="products-dd-menu"]//div[@role="tablist"]//button//span)
${menus}    (//span[text()='{name}'])[{count}]/parent::div/parent::div[contains(@class,' bstack-mm-sub-nav-tabcol')][1]/div/a/span
${sub_menu}    //div[@id='products-dd-tabpanel-{tab_count}']/div[@id='products-dd-tabpanel-{tab_count}-inner-1']/div[contains(@class,' bstack-mm-sub-nav-tabcol')][{index}]/div/a/span
${column_count}    //div[@id='products-dd-tabpanel-{tab_count}']/div[@id='products-dd-tabpanel-{tab_count}-inner-1']/div[contains(@class,' bstack-mm-sub-nav-tabcol')]
${column_count_dy}    (//div[@id='products-dd-tabpanel-{tab_count}']/div[@id='products-dd-tabpanel-{tab_count}-inner-1']/div[contains(@class,' bstack-mm-sub-nav-tabcol')]/div/span)[{elements}]
${Attributes}    innerText
${Test}    Test
${Automation}    Automation
${Automate}    Automate
${title_submenu}    //div[@id="products-dd-tabpanel-1-inner-1"]//div[@class='bstack-mm-sub-nav-tabpanel-heading ']
*** Keywords ***
Launch Application
    open browser    ${url}    ${browser}
    Maximize Browser Window
*** Test Cases ***
TC1
    Launch Application
    Mouse Over    ${product}
    
    Wait Until Element Is Visible    ${web_testing}
    ${count}    Get Element Count    ${sub_menus}
    ${dict}    Create Dictionary
    FOR    ${counter}    IN RANGE    1    ${count}+1
        Mouse Over    (${sub_menus})[${counter}]
        Take Screenshot
        ${heading}    Get Element Attribute    (${sub_menus})[${counter}]    ${Attributes}
        ${output_list}    Create Dictionary  
        ${col_count_dy}    Format String    ${column_count}    tab_count=${counter}
        ${col_count}    Get Element Count    ${col_count_dy}
        FOR    ${element}    IN RANGE    1    ${col_count}  
            ${menu}    Format String    ${sub_menu}    tab_count=${counter}    index=${element}
            ${counts}    Get Element Count    ${menu}
            ${sub_menu_heading}    Format String    ${column_count_dy}    tab_count=${counter}    elements=${element}
            ${menu_heading}    Get Element Attribute    ${sub_menu_heading}    ${Attributes}
            ${titles_list}    Create List  
            FOR    ${counters}    IN RANGE    1    ${counts}+1
                ${title_element}    Format String    ${menus}    name=${menu_heading}    count=${counter}
                ${title}    Get Element Attribute    (${title_element})[${counters}]    ${Attributes}
                ${status1}    Run Keyword And Return Status    Should Contain    ${title}    ${Test}
                ${status2}    Run Keyword And Return Status    Should Contain    ${title}    ${Automate}
                ${status3}    Run Keyword And Return Status    Should Contain    ${title}    ${Automation}
                IF    ${status1} or ${status2} or ${status3}
                    Append To List    ${titles_list}    ${title}
                END
            END
            Set To Dictionary    ${output_list}    ${menu_heading}    ${titles_list}
        END
        Set To Dictionary    ${dict}    ${heading}    ${output_list}
    END
 
    Log    ${dict}
 
