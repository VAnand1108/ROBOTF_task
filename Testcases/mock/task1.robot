*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Library    RPA.Excel.Files
*** Variables ***

${url}    https://docs.telerik.com/devtools/winforms/api/

${browser}    chrome
${attribute}    innerText

${window_control}    //a[@title="Telerik.WinControls"]
${interfaces}      //h3[@id="interfaces"]

${interface_title}   ((//h3[@id="interfaces"]//following-sibling::div[@class="table-responsive"])[1]//following::tbody)[1]//td/p[not(normalize-space(.)='') and not(a)]/preceding-sibling::p/a
${interface_title_dy}    (((//h3[@id="interfaces"]//following-sibling::div[@class="table-responsive"])[1]//following::tbody)[1]//td/p[not(normalize-space(.)='') and not(a)]/preceding-sibling::p/a)[{index}]
${interface_para}      ((//h3[@id="interfaces"]//following-sibling::div[@class="table-responsive"])[1]//following::tbody)[1]//td/p[not(normalize-space(.)='') and not(a)]  
${interface_para_dy}    (((//h3[@id="interfaces"]//following-sibling::div[@class="table-responsive"])[1]//following::tbody)[1]//td/p[not(normalize-space(.)='') and not(a)])[{index}]

# ########

${url2}    https://www.telerik.com/
${search_icon}    (//div[@id="js-tlrk-nav-drawer"]//following::a[@title="Search"])[1]
${search_entry}    //input[@placeholder="search"]
${kendo_link}    //a[text()="https://www.telerik.com/kendo-ui"]
${kendo_url}    https://www.telerik.com/kendo-ui
${links1}     //li[@class="TK-Search-Results-List-Item"]
${heading}    //a[@href="{url}"]/parent::div/preceding-sibling::h4/a
${links}    (//li[@class="TK-Search-Results-List-Item"]//div/a)
${links_dy}    (//li[@class="TK-Search-Results-List-Item"]//div/a)[{index}]
${no_of_page}    //div[@class="TK-Pager-Links"]/a
${no_of_page_Dy}    (//div[@class="TK-Pager-Links"]/a)[{index}]    


*** Keywords ***

open the browser and click on windowscontrol and select for interfaces

    Open Browser    ${url}    ${browser}
    Maximize Browser Window
    Sleep    3

    Wait Until Page Contains Element    ${window_control} 
    Scroll Element Into View    ${window_control} 
    Click Element    ${window_control} 
    Wait Until Page Contains Element    ${interfaces}
    Scroll Element Into View    ${interfaces} 
    Click Element    ${interfaces} 
    
    ${title_cnt}    Get Element Count    ${interface_title}
    Log    ${title_cnt}
    
    ${output_key_dic}    Create Dictionary
    # ${output_key_dic}    Create List
    FOR    ${counter}    IN RANGE    1    ${title_cnt}+1
        ${formated_title_xpath}    Format String    ${interface_title_dy}    index=${counter}
        ${formatted_title}    Get Element Attribute    ${formated_title_xpath}    ${attribute}
        
        ${formated_para}    Format String    ${interface_para}    index=${counter}
        ${para_cnt}    Get Element Count    ${formated_para}    
        ${desc_list}    Create List

        ${formated_para_xpath}    Format String    ${interface_para_dy}    index=${counter}
        ${formatted_para}    Get Element Attribute    ${formated_para_xpath}    ${attribute}
        Append To List    ${desc_list}     ${formatted_para}  
    
    Set To Dictionary    ${output_key_dic}    ${formatted_title}=${desc_list}
    END
    Log    ${output_key_dic}

open the browser click for search icon and get the kendo-ui and store the data into excel

    Open Browser    ${url2}    ${browser}
    Maximize Browser Window
    Sleep    3
    Create Workbook    Testcases/data.xlsx   sheet_name=Sheet1
    ${dic}    Create Dictionary
    Wait Until Page Contains Element    ${search_icon} 
    Click Element    ${search_icon} 
    Wait Until Page Contains Element    ${search_entry}

    Scroll Element Into View    ${kendo_link}
    ${kendo_element_txt}    Get Element Attribute    ${kendo_link}    ${attribute} 
    
    Scroll Element Into View    ${search_entry}
    Input Text    ${search_entry}    ${kendo_element_txt}
    Press Keys    ${search_entry}    ENTER
    Sleep    3
    ${count}    Get Element Count    ${links1}
    Log    ${count}
    Capture Page Screenshot

    ${link_list}    Create List

    ${pages}    Get Element Count    ${no_of_page}
    FOR    ${counter}    IN RANGE    1     ${pages}+1
        ${pg}    Format String    ${no_of_page_Dy}    index=${counter}
        Wait Until Element Is Visible    ${pg}
        Click Element    ${pg}
        
        FOR    ${counter}    IN RANGE    1    ${count}+1
            ${formated_linkcnt}    Format String    ${links_dy}       index=${counter}  
            ${link_atr}    Get Element Attribute    ${formated_linkcnt}    ${attribute}
            Append To List    ${link_list}     ${link_atr}   

            IF    $kendo_url == $link_atr
                ${formatted_loc}    Format String    ${heading}    url=${link_atr}
                ${text}    Get Element Attribute    ${formatted_loc}    ${attribute}
                Set To Dictionary    ${dic}   ${text}= ${link_atr} 
                Append Rows To Worksheet    ${dic}    header=True
                # Append To List    ${link_list}      ${text}
                
            END  
        END
        
    END
    Log    ${dic}
    Save Workbook





        # FOR    ${counter}    IN RANGE    1    ${count}+1
        #     ${formated_linkcnt}    Format String    ${links_dy}       index=${counter}  
        #     ${link_atr}    Get Element Attribute    ${formated_linkcnt}    ${attribute}
        #     Append To List    ${link_list}     ${link_atr}   

        #     IF    $kendo_url == $link_atr
        #         ${formatted_loc}    Format String    ${heading}    url=${link_atr}
        #         ${text}    Get Element Attribute    ${formatted_loc}    ${attribute}
        #         Set To Dictionary    ${dic}   ${text}= ${link_atr} 
        #         Append Rows To Worksheet    ${dic}    header=True
        #         # Append To List    ${link_list}      ${text}
                
        #     END  
        # END

*** Test Cases ***
tc01
    [Tags]      Dictionary  
    open the browser and click on windowscontrol and select for interfaces
tc02
    [Tags]    Excel
    open the browser click for search icon and get the kendo-ui and store the data into excel

    
    
