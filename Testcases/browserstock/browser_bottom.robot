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


${title_list}     (//p[@class="footer-habitat__heading"])[{count}]/parent::div//span
${title_list_dy}    ((//p[@class="footer-habitat__heading"])[{count}]/parent::div//span)[{index}]
*** Test Cases ***
tc01
    
    Open Browser    ${url}    ${browser}
    Maximize Browser Window

    Scroll Element Into View    ${title}
    ${title_count}    Get Element Count    ${title}
    Log    ${title_count} 

    ${output_heading}    Create List
    ${dict}    Create Dictionary

    
    

    FOR    ${counter}    IN RANGE    1    ${title_count}    

       ${formatted_title}    Format String    ${title_dy}    count=${counter}
        ${header}    Get Element Attribute    ${formatted_title}     ${attribute}
        Append To List     ${output_heading}    ${header} 
        
        ${formatted_title_dy}    Format String    ${title_list_dy}    count=${counter}
        ${title_list_items}    Get Element Count   ${formatted_title_dy} 
        Log    ${title_list_items}


        ${product_items}    Create List
        FOR    ${counter1}    IN RANGE    1    ${title_list_items}+1
            Scroll Element Into View    ${title_list_items}
            ${formatted_values}    Format String    ${title_list_dy}    count=${counter}    
            ${header_products}    Get Element Attribute    ${formatted_values}      ${attribute}
            Append To List    ${product_items}    ${header_products}
        END
        Log    ${product_items}
        Set To Dictionary    ${dict}    ${header}=${product_items}   
    END
    # Log    ${output_heading} 
    # Log    ${title_list_items}
    Log    ${dict}



    