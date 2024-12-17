*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections


*** Variables ***
${url}   https://www.browserstack.com/
${browser}    chrome
${attribute}    innerText
# ${Products-Menu}    //button[@type="button"]/ancestor::ul[@class="TK-Products-Menu"]
${title}   (//div[@class="bottom-section__links-v3"]//following::p[@class="footer-habitat--v3-heading"])
${title_dy}    (${title})[{index}]

${inner_links}    ((${title})[{index}]//following-sibling::ul/li)
${inner_links_dy}    (${inner_links})[{index2}]

*** Keywords ***
footer Dictionary

    Open Browser    ${url}    ${browser}
    Maximize Browser Window
    Sleep    3
    Scroll Element Into View    ${title}
    ${menus}    Get Element Count    ${title}
    ${output_dic}    Create Dictionary
    FOR    ${Titles}    IN RANGE    1    ${menus}+1
        ${formatted_title_xpath}    Format String    ${title_dy}    index=${Titles}
        ${formatted_title_name}    Get Element Attribute    ${formatted_title_xpath}     ${attribute}
        ${submenu_output}    Create List
        ${formatted_inner_links}    Format String    ${inner_links}    index=${Titles}
        ${submenu}    Get Element Count   ${formatted_inner_links}
        FOR    ${submenuss}    IN RANGE    1    ${submenu}+1
            ${formatted_submenu_xpath}    Format String    ${inner_links_dy}     index=${Titles}    index2=${submenuss}
            ${formatted_submenu_name}    Get Element Attribute    ${formatted_submenu_xpath}    ${attribute}

            Append To List    ${submenu_output}     ${formatted_submenu_name} 
        END

        ${list_cnt}    Get Length    ${submenu_output}
        IF    $list_cnt == 4
           Set To Dictionary     ${output_dic}     ${formatted_title_name}=${submenu_output} 
        END
        # Set To Dictionary     ${output_dic}     ${formatted_title_name}=${submenu_output}
    END
    Log    ${output_dic}

*** Test Cases ***
tc01    
    footer Dictionary