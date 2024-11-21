*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
 
*** Variables ***
${url}    https://www.browserstack.com/
${browser}    chrome
${price_btn}    //a[@title='Pricing']
${side_nav}    //div[@id='sidenav__list']//a[not(contains(@data-family,'app_testing'))]
${side_nav_dyn}    (//div[@id='sidenav__list']//a[not(contains(@data-family,'app_testing'))])[{count}]
${side_nav_link}    //div[contains(@class,'{text}')]/parent::div[@data-mobile-view="false" and not(@data-plan-name="Enterprise")]//div[@class='plan-header-container']//div[contains(@class,'plan-name')]
${side_nav_link_dyn}    (//div[contains(@class,'{text}')]/parent::div[@data-mobile-view="false" and not(@data-plan-name="Enterprise")]//div[contains(@class,'plan-name')])[{count}]
${side_nav_link_price}  (//div[contains(@class,'{text}') and contains(@data-plan-name,'{text_upper}')]/parent::div[@data-mobile-view="false"]//div[contains(@class,'plan-pricing-info')]//span[@class='amount'])[{count}]
${empty}

 
*** Test Cases ***
test03
    Open Browser    ${url}    ${browser}
    Maximize Browser Window
    Click Element    ${price_btn}
    ${title_list}    Create List
    ${heading_list}    Create List
    ${output_dict}    Create Dictionary
    ${title_count}    Get Element Count    ${side_nav}
    FOR    ${counter}    IN RANGE    1    ${title_count}+1

        ${element}    Format String    ${side_nav_dyn}    count=${counter}
        ${title}    Get Element Attribute    ${element}    title
        Click Element    ${element}
        ${camel_case}    Set Variable    ${title}
        ${title}    Convert To Lower Case    ${title}
        ${heading_path}    Format String    ${side_nav_link}    text=${title}
        ${heading_count}    Get Element Count    ${heading_path}


        FOR    ${counter}    IN RANGE    1    ${heading_count}+1
            ${element}    Format String    ${side_nav_link_dyn}    text=${title}    count=${counter}
            ${heading_text}    Get Text    ${element}
            IF    $heading_text != $empty
                IF    $heading_text not in $heading_list
                    ${u_text}    Set Variable   ${title}
                    ${u_text}    Convert To Upper Case    ${u_text}
                    ${element}    Format String    ${side_nav_link_price}    text=${title}    text_upper=${camel_case}    count=${counter}
                    Wait Until Element Is Visible    ${element}
                    ${price}    Get Text    ${element}
 
                    Append To List    ${heading_list}    ${heading_text}:price-->${price}    
                END
               
            END
        END
        Set To Dictionary    ${output_dict}    ${title}    ${heading_list}
    END
   
    FOR    ${key}    IN    @{output_dict.keys()}
        ${data}    Get From Dictionary    ${output_dict}    ${key}
        Log    ${key} ---> ${data}        
    END