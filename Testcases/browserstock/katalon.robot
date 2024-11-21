*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String

*** Variables ***
${url}    https://katalon.com/integrations
${browser}    chrome

${viewall}    //div[text()="View all"]/ancestor::div[@class="content"]
${a_text}    //div[starts-with(text(),"A")]/ancestor::div[@class="application"]
${a_text_dy}    (//div[starts-with(text(),"A")]/ancestor::div[@class="application"])[{count}]
${decription_text}    //div[@class="text"]
${Atlassian}    Atlassian
${close_btn}    //div[text()="x"]
*** Test Cases ***
tc01
    Open Browser    ${url}    ${browser}
    Maximize Browser Window
    Wait Until Page Contains Element    ${viewall} 
    Click Element    ${viewall} 
    Wait Until Page Contains Element    ${a_text} 
    ${a_count}    Get Element Count    ${a_text} 
    Log    ${a_count}
    ${output_dict}    Create Dictionary
    ${description_output}    Create List

    ${dict}    Create Dictionary

    FOR    ${counter}    IN RANGE    1     ${a_count}+1    
        ${formated_text}    Format String       ${a_text_dy}    count=${counter}
       ${title}     Get Element Attribute   ${formated_text}      innerText
        
       IF    $Atlassian in $title
           Click Element    ${formated_text}
            ${description_content}    Get Element Attribute    ${decription_text}     innerText
            Append To List    ${description_output}    ${description_content}    #getting atlastian> description para 
            Set To Dictionary    ${dict}    Description=${description_output}  #atlastian-descrption  
           Click Element    ${close_btn}
            Set To Dictionary    ${output_dict}     ${title}=${dict}  #title-atlastian-descrption
        END    
        # Append To List    ${output_list}    ${title}
    END
    Log    ${dict}
    Log    ${output_dict}
    