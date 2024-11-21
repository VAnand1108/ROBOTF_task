*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String
 
*** Variables ***
${url}    https://www.browserstack.com/support
${browser}    chrome
${attribute}    innerText
 
${title}    //p[@class="footer-habitat__heading"]
${title_dy}    (//p[@class="footer-habitat__heading"])[{count}]
 
 
${title_list_dy}     (//p[@class="footer-habitat__heading"])[{count}]/parent::div//span
${title_list_individual}    ((//p[@class="footer-habitat__heading"])[{count}]/parent::div//span)[{count2}]
 
*** Test Cases ***
tc01
   
    Open Browser    ${url}    ${browser}    Options=addArguments("--incognito")
    Maximize Browser Window
 
    Scroll Element Into View    ${title}
    ${title_count}    Get Element Count    ${title}
   
    ${dict}    Create Dictionary
   
 
    FOR    ${counter}    IN RANGE    1    ${title_count} + 1  
 
        ${formatted_title}    Format String    ${title_dy}    count=${counter}
        ${header}    Get Element Attribute    ${formatted_title}     ${attribute}
       
        ${product_items}    Create List
 
        ${formatted_title_dy}    Format String    ${title_list_dy}    count=${counter}
        ${title_list_items}    Get Element Count    ${formatted_title_dy}
 
        FOR    ${counter2}    IN RANGE    1    ${title_list_items} + 1
            ${formatted_values}    Format String    ${title_list_individual}    count=${counter}    count2=${counter2}
            ${header_products}    Get Element Attribute    ${formatted_values}      ${attribute}
            Append To List    ${product_items}    ${header_products}
           
        END
        Set To Dictionary    ${dict}    ${header}=${product_items}
    END
   
    Log    ${dict}