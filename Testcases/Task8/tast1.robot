*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Library    RPA.Excel.Files


*** Variables ***
${url}    https://help.yahoo.com/
${brswer}    chrome
${count}    (//div[@id="faqdiv"]/div//article//h1)
# ${count_dy}     (//div[@id="faqdiv"]/div//article//h1)[{index}]    
${mail}    //nav[@id="productsdiv"]/ul/li/a[text()="Mail"]


${see_more}    //a[text()="See"]
${see_more_count}   (//a[text()="See"]/following::div[@class="site-navigation-more"]//ul/li)

${count_dy}   (//a[text()="See"]/following::div[@class="site-navigation-more"]//ul/li)[{index}]  
${shopping}     (//a[text()="See"]/following::div[@class="site-navigation-more"]//ul/li/a[contains(text(),"Shopping")])
${shoping_text}    Shopping
${t}    //div[@id="article_container"]/article/h3
${t1}    //div[@id="article_container"]/article/h3[{index}]



*** Keywords ***
launch and get count 

    Open Browser    ${url}    ${brswer}    option= add_argument("--incognito")
    Maximize Browser Window
    # Wait Until Page Contains Element    ${mail}
    # Click Element    ${mail}
    

    # Create Workbook    Testcases/Task8/data.xlsx     sheet_name=sheet1
    # ${dict}    Create Dictionary    

    # ${new_xpath}    Get Element Count    ${count}

    # FOR    ${counter}    IN RANGE    1    ${new_xpath}+1 
    #    ${new_text}    Format String     ${count_dy}    index=${counter}
    #    ${new_title}    Get Element Attribute    ${new_text}    innerText
    #     Set To Dictionary    ${dict}    title=${new_title}
    #     Append Rows To Worksheet    ${dict}    header=${True}
    # END
    # Save Workbook
    # Log    ${dict}



    Wait Until Page Contains Element    ${see_more}
    Click Element    ${see_more}
    ${new_path}    Get Element Count    ${see_more_count}
    
    ${dict}    Create Dictionary


    FOR    ${counter}    IN RANGE    1    ${new_path}+1    
        ${get_text}    Format String    ${count_dy}    index=${counter}
        ${get_title}    Get Element Attribute    ${get_text}    innerText
        IF    $shoping_text in $get_title
            Click Element    ${get_text}
            Capture Page Screenshot
            
        END
        Set To Dictionary    ${dict}    title${counter}=${get_title}
        
    END
    

    Log     ${dict}



tc1
    
    Open Browser    https://help.yahoo.com/kb/account/fix-problems-signing-yahoo-account-sln2051.html    ${brswer}    OPTIONS=argument(--incognito)
    Maximize Browser Window
    Sleep    3


    ${dict}    Create Dictionary
    ${a}    Get Element Count    ${t}

    FOR    ${counter}    IN RANGE    1    ${a}+1    
        ${tt}    Format String    ${t1}    index=${counter}
        Wait Until Page Contains Element    ${tt}
        Click Element    ${tt}
        # Sleep    100s
        FOR    ${counter}    IN RANGE    START    END    opt.STEPS
            Log    ${counter}
            
        END
    END


*** Test Cases ***
tc02
    # launch and get count
    tc1