*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String

*** Variables ***
${url}    https://www.browserstack.com/support
${browser}    chrome
${attribute}    innerText
${other_name}    //h2[text()="Other Tools"]
${othertool_name}    //h2[text()="Other Tools"]//following::div[@class="card-b-6__block-content"]/div[@class="card-b-6__block-title"]
${othertool_desc}    //h2[text()="Other Tools"]//following::div[@class="card-b-6__block-content"]//div[@class="card-b-6__block-desc"]
${othertool_desc_dy}    (//h2[text()="Other Tools"]//following::div[@class="card-b-6__block-content"]//div[@class="card-b-6__block-desc"])[{count}]
${othertool_name_dy}    (//h2[text()="Other Tools"]//following::div[@class="card-b-6__block-content"]/div[@class="card-b-6__block-title"])[{count}]

*** Test Cases ***
tc01    
    Open Browser    ${url}    ${browser}
    Maximize Browser Window
    
    Scroll Element Into View    ${other_name}
    Wait Until Page Contains Element    ${othertool_name}
    ${count_name}    Get Element Count    ${othertool_name} 
    Log    ${count_name} 

    ${others_list}    Create List
    ${job}    Create Dictionary
    FOR    ${counter}    IN RANGE    1    ${count_name}+1  
        ${dict}    Create Dictionary  
        ${formatted_text}    Format String    ${othertool_name_dy}    count=${counter}
        ${title}    Get Element Attribute    ${formatted_text}    ${attribute}

        ${formatted_desc}    Format String    ${othertool_desc_dy}    count=${counter}
        ${description}    Get Element Attribute    ${formatted_desc}    ${attribute}
       ${a}    Set To Dictionary    ${dict}    name=${title}    desc=${description}
       Append To List    ${others_list}     ${a}         

    END
    ${output}    Set To Dictionary    ${job}    job=${others_list}
    Log    ${others_list} 
    Log    ${output} 