*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Library    RPA.FileSystem


*** Variables ***
${url}    https://www.browserstack.com/docs/percy/integrate/percy-with-browserstack-sdk
${browser}    chrome
${attribute}    innerText

${percy_sdk}    //a[text()="Percy SDK"]
${heading}    //div[@data-tag="Percy_SDK"]//following::h2
${heading_dy}    (//div[@data-tag="Percy_SDK"]//following::h2)[{index}]
${heading_link}   (((//div[@data-tag="Percy_SDK"]//following::h2)[{index}]//following-sibling::ul))
${a_link}    ((//div[@data-tag="Percy_SDK"]//following::h2)[{index}]//following-sibling::ul)[{index1}]//a
${a_link_dy}    (((//div[@data-tag="Percy_SDK"]//following::h2)[{index}]//following-sibling::ul)[{index1}]//a)[{index}]
# 
# 
*** Keywords ***
open the application and get the datas and store in the Dictionary
    Open Browser    ${url}    ${browser}
    Maximize Browser Window
    Sleep    3

    Wait Until Element Is Visible    ${percy_sdk}
    Click Element    ${percy_sdk}
    Wait Until Page Contains Element    ${percy_sdk}
    ${count}    Get Element Count    ${heading} 
    Log    ${count}
    
    ${heading_dic}    Create Dictionary
    ${heading_list}    Create List

    FOR    ${counter}    IN RANGE    1    ${count}+1
        ${formated_title}    Format String    ${heading_dy}    index=${counter}
        Wait Until Page Contains Element    ${formated_title}
        Scroll Element Into View    ${formated_title}
        ${formated_heading}    Get Element Attribute    ${formated_title}     ${attribute} 

        Wait Until Page Contains Element    ${formated_title} 
        ${a}    Get Element Count     ${a_link}    
        Log    ${a}

        FOR    ${counter1}    IN RANGE    1    ${a}+1
            ${fomatted_link}    Format String    ${a_link_dy}     index1=${counter1}  
            ${formated_href}    Get Element Attribute    ${fomatted_link}    href    

        END


        ${output_heading}    Append To List    ${heading_list}    ${formated_heading}
        Set To Dictionary    ${heading_dic}    ${formated_heading}    ${output_heading}

    END
    log ${heading_dic}
    Log    ${heading_list}

*** Test Cases ***
tc01
    open the application and get the datas and store in the Dictionary







    # Scroll Element Into View    ${title}
    # ${count}     Get Element Count    ${title}
    # Log    ${count}
    # ${output_list}    Create List

    # FOR    ${counter}    IN RANGE    ${count}+1
        
    #     ${formated_text}    Format String    ${title_dy}    index=${counter}
    #     ${tittle}    Get Element Attribute    ${formated_text}     ${attribute}     
    #     Append To List  ${output_list}    ${title}  
    # END

    # Log    ${output_list}

# ${title}    (//h2[text()="The most advanced visual testing algorithm"]//following::div)[1]//h5
# ${title_dy}    ((//h2[text()="The most advanced visual testing algorithm"]//following::div)[1]//h5)[{index}]
