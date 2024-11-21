*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String
Library    Process
Library    RPA.Desktop
Library    RPA.Excel.Files
Variables    ../../Testcases/Task6/data.py
Variables    ../../Testcases/Task6/xpath.py


*** Keywords ***

Launch the browser    
    Open Browser       ${realeasenote_url}    ${browser}
    Maximize Browser Window
    Sleep    5
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    # Sleep    100s
    Wait Until Page Contains Element       ${career_site}  
    Click Element     ${career_site}
    
    Wait Until Page Contains Element    ${view_open_position}
    Click Element    ${view_open_position}
    Sleep    10s
    Capture Page Screenshot
get the role,location and posted date
    ${details_dict}    Create Dictionary
    ${count_dict}    Create Dictionary
    Switch Window    NEW
    # Scroll Element Into View    //a[@data-automation-id="jobTitle"]
    Wait Until Page Contains Element   ${j_title}    10s
    ${counter}    Get Element Count    ${j_title}

    FOR   ${element}  IN RANGE    1  ${counter}+1
        ${title_name}    Get Element Attribute    (${j_title})[${element}]    ${Attribute}
        IF    $title_name in @{count_dict}
            ${counter}    Get From Dictionary    ${count_dict}    ${title_name} 
            ${counter}    Evaluate    ${counter}+1
            Set To Dictionary    ${count_dict}    ${title_name}    ${counter}
        ELSE
            Set To Dictionary    ${count_dict}    ${title_name}    1
        END
        ${Job_id}    Get Element Attribute    (${j_id})[${element}]    ${Attribute}
        ${Posted_date}    Get Element Attribute    (${post_date})[${element}]    ${Attribute}
        Set To Dictionary    ${details_dict}    Name:${title_name}    Job_id:${Job_id}, posted_date:${Posted_date}    
    END
    Log    ${details_dict}
    Log    ${count_dict}

store datas into excel
    # Open Workbook    ${file_path}
    Create Workbook    Testcases/Task6/data.xlsx    sheet_name=Sheet1
    Create Worksheet    Sheet2
    # Save Workbook
    ${details_dict}    Create Dictionary
    ${count_dict}    Create Dictionary
    Switch Window    NEW
    # Scroll Element Into View    //a[@data-automation-id="jobTitle"]
    Wait Until Page Contains Element   ${j_title}    10s
    ${counter}    Get Element Count    ${j_title}

    FOR   ${element}  IN RANGE    1  ${counter}+1
        ${title_name}    Get Element Attribute    (${j_title})[${element}]    ${Attribute}
        IF    $title_name in &{count_dict}.keys()
            ${counter}    Get From Dictionary    ${count_dict}    ${title_name} 
            ${counter}    Evaluate    ${counter}+1
            Set To Dictionary    ${count_dict}    name=${title_name}    count=${counter}
            Set Active Worksheet    Sheet2
            Append Rows To Worksheet    ${count_dict}

        ELSE
            Set To Dictionary    ${count_dict}    name=${title_name}    count=1
            Set Active Worksheet    Sheet2
            Append Rows To Worksheet    ${count_dict}
        END
        ${Job_id}    Get Element Attribute    (${j_id})[${element}]    ${Attribute}
        ${Posted_date}    Get Element Attribute    (${post_date})[${element}]    ${Attribute}
        Set To Dictionary    ${details_dict}    Name=${title_name}    Job_id=${Job_id}    posted_date=${Posted_date}    
        Set Active Worksheet    Sheet1

        Append Rows To Worksheet    ${details_dict}     header=${True}
        
    END
    Save Workbook
    Log    ${details_dict}
    Log    ${count_dict}
*** Test Cases ***
tc06
    Launch the browser  
    # get the role,location and posted date
    store datas into excel