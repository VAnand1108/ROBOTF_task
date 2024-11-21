*** Settings ***

Library    SeleniumLibrary
# Library    ExcelLibrary
Library    RPA.Excel.Files
Library    RPA.Tables
Library    Collections
Library    OperatingSystem

*** Variables ***

${excel_path}    Testcases/excelTask/test data.xlsx
${googl_url}    https://www.google.com/
${search_field}    //textarea[@role="combobox"]


*** Keywords ***
open the excel and read the datas
    
    Open Workbook    ${excel_path}   
    ${data}    Read Worksheet As Table     header=True
    Log    ${data}

open excel and sum the salary based on department
    Open Workbook    ${excel_path}   
    ${data}    Read Worksheet As Table     header=True
    ${output_data}    Get Length    ${data}
    Log    ${data}
    ${output_list}    Create List
    FOR    ${i}    IN RANGE    0    ${output_data}  
        ${a}    Get Table Row    ${data}       ${i}     
        Append To List    ${output_list}    ${a}
        
    END

    Log    ${output_list}
    Set Global Variable    ${output_data}
    Set Global Variable    ${output_list}

Dept wise salary
    ${sum_dict}    Create Dictionary
    ${cites}    Create List

    Open Workbook    ${excel_path}   
    ${table}    Read Worksheet As Table     header=True
    ${table_row}    Get Length    ${table}




    FOR    ${counter}    IN RANGE    0    ${table_row}
        ${excel_data}    Get Table Row    ${table}    ${counter}
        ${dept_key}    Set Variable    ${excel_data['Dept']}
      
      
      IF    $dept_key in $sum_dict
            ${old_sal}    Get From Dictionary    ${sum_dict}    ${dept_key}
            ${salary}    Evaluate    ${old_sal}+${excel_data['Salary']}
            Set To Dictionary    ${sum_dict}    ${dept_key}    ${salary}
            Log    ${sum_dict}
        ELSE
            Set To Dictionary    ${sum_dict}    ${dept_key}    ${excel_data['Salary']}   
            

        END
    Append To List    ${cites}    ${excel_data['City_2']}
        
    END
    Log    ${sum_dict}
    Log    ${cites}
    Set Global Variable    ${cites}



search for cites and get the link
    Open Browser     ${googl_url}    chrome
    Maximize Browser Window

    ${district_links}    Create Dictionary
    
    FOR    ${cite_name}    IN    @{cites}
        ${links_list}    Create List
        Input Text    ${search_field}    ${cite_name}
        Press Keys    ${search_field}    ENTER
        ${links_count}    Get Element Count    //a
        FOR    ${counter}    IN RANGE    1    ${links_count}+1
            ${link}    Get Element Attribute    (//a)[${counter}]    href
            IF    $link != None
                Log    ${link}
                Append To List    ${links_list}    ${link}  
            END            
        END
        Set To Dictionary    ${district_links}    ${cite_name}=@{links_list}


    END
    Log    ${district_links}
    ${chennai_links}    Set Variable    ${district_links['Chennai']}
    Log    ${chennai_links}

    # FOR    ${element}    IN    @{chennai_links}
    #     Execute Javascript    window.open()
    #     Switch Window    New
    #     Go To    ${element}
    #     sleep    3s

    # END

*** Test Cases ***

Reading Excel Datas
    # open the excel and read the datas
    open excel and sum the salary based on department
    Dept wise salary
    search for cites and get the link
