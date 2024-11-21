*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Library    Screenshot

*** Variables ***
${url}    https://www.browserstack.com/
${browser}    chrome
${attribute}    innerText
${product_tab_btn}    //button[@id="products-dd-toggle"]
${web_test_btn}           //span[text()='Web Testing']
${app_test_btn}    //button[@aria-label="App Testing"]/span[text()="App Testing"]
${web_test_tab}    //div[@id="products-dd-tabpanel-1"]
${app_test_tab}    //div[@id="products-dd-tabpanel-2"]
${template_web}    //div[@id="products-dd-tabpanel-1-inner-1"]//a[contains(@aria-label,"{name}")]//span
${template_web_individual}    (//div[@id="products-dd-tabpanel-1-inner-1"]//a[contains(@aria-label,"{name}")]//span)[{count}]


${app_test_tab}    //div[@id="products-dd-tabpanel-2"]
${template_app}    //div[@id="products-dd-tabpanel-2-inner-1"]//a[contains(@aria-label,"{name}")]//span
${template_app_individual}    (//div[@id="products-dd-tabpanel-2-inner-1"]//a[contains(@aria-label,"{name}")]//span)[{count}]
${title_name}     //div[@id="products-dd-tabpanel-1-inner-1"]//a[contains(@aria-label,"{name}")]/parent::div/parent::div/div[contains(@class,"bstack-mm-sub-nav-tabpanel-heading ")]/span
*** Keywords ***

launch browserstock and capture page element and pick the automate and test
    
    Open Browser    ${url}    ${browser}
    Maximize Browser Window
    Wait Until Page Contains Element    ${product_tab_btn}
    Mouse Over    ${product_tab_btn}
    Take Screenshot
    web testing
    # app test
    
web testing 
    ${web_text}    Create List    Test    Automate
    ${web_output_list}    Create List
    ${attr_list}    Create List    
    &{result_dict}    Create Dictionary

    ${web_dict}    Create Dictionary    
    Set To Dictionary    ${result_dict}    web_testing=${web_dict}

    FOR    ${element}    IN    @{web_text}
        ${formated_text}    Format String    ${template_web}    name=${element}
        ${count}    Get Element Count    ${formated_text}
        FOR    ${counter}    IN RANGE    1    ${count}+1
        
            ${title_xpath}    Format String    ${title_name}    name=${element}
            ${title_value}    Get Text    ${title_xpath}
            Log    title ${title_value}

            ${formated_text_individual}    Format String    ${template_web_individual}    name=${element}    count=${counter}
            ${innerText}    Get Element Attribute    ${formated_text_individual}    innerText
            Log    text :${innerText}
            Append To List   ${web_output_list}     ${innerText}

            IF    $title_value in ${result_dict['web_testing']}
                ${results_list}    Get From Dictionary    ${result_dict['web_testing']}    ${title_value}
                Append To List    ${results_list}     ${innerText}
                Set To Dictionary    ${result_dict['web_testing']}    ${title_value}=${results_list}
            ELSE
                ${results_list}    Create List
                Append To List    ${results_list}    ${innerText}
                Set To Dictionary    ${result_dict['web_testing']}    ${title_value}=${results_list}
            END

        END

    END
    Log    WebTesting->${web_output_list} 
    Log    final dict -> ${result_dict}
    
app test
    ${app_text}    Create List    Test    Automate
    ${app_output_list}    Create List
    FOR    ${element}    IN    @{app_text}
        ${formated_text}    Format String    ${template_app}    name=${element}

        ${count}    Get Element Count    ${formated_text}
        FOR    ${counter}    IN RANGE    1    ${count}+1
            ${formated_text_individual}    Format String    ${template_app_individual}    name=${element}    count=${counter}
            ${innerText}    Get Element Attribute    ${formated_text_individual}    innerText
            Log    text :${innerText}
            Append To List   ${app_output_list}     ${innerText}

        END

    END
    Log    AppTesting->${app_text} 
*** Test Cases ***

tc01
    launch browserstock and capture page element and pick the automate and test
    app test

    

