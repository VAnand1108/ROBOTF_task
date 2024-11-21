*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String
Library    Process
Library    RPA.Desktop
Variables    ../../Testcases/Task5/data.py
Variables    ../../Testcases/Task5/xpath.py


*** Keywords ***
Open Amazon Website
    [Documentation]    Open Amazon India homepage.
    Open Browser    ${amazon_url}    ${browser}
    Maximize Browser Window
    Sleep    5
    Scroll Element Into View    ${deals_section}
    Sleep    5


Get All Blockbuster Deals
    [Documentation]    Fetches all blockbuster deals and captures discount percentages, titles, and prices.
    ${discount_list}    Create List
    ${deal_dict}    Create Dictionary
    ${high_low_list}    Create List
    ${count}    Get Element Count    ${products}
    
    FOR    ${counter}    IN RANGE    1    ${count}+1
        ${discount_xpath_formatted}    Format String    ${discount_amount_xpath}    index=${counter}
        ${discount_text}    Get Element Attribute    ${discount_xpath_formatted}    ${Attribute}
        ${discount_value}    Fetch From Left    ${discount_text}    ${precentage_symbol}
        ${discount_value}    Convert To Integer    ${discount_value}
        Append To List    ${discount_list}    ${discount_value}    
      
        
    END
    Sort List    ${discount_list}
    # sorting lowest and highest discount 
    ${Lowest_discount}    Set Variable    ${discount_list}[0]
    ${last_index}    Evaluate    len(${discount_list})-1
    ${Highiest_discount}    Set Variable    ${discount_list}[${last_index}]
    
    ${low_discount_path}    Format String    ${discount_new_path}    text=${Lowest_discount}    
    ${high_discount_path}    Format String    ${discount_new_path}    text=${Highiest_discount}
    Append To List    ${high_low_list}    ${low_discount_path}    ${high_discount_path}
    

    FOR    ${element}    IN    @{high_low_list}

        ${element_count}    Get Element Count    ${element}

        FOR    ${counter}    IN RANGE    1    ${element_count}+1
            Scroll Element Into View    (${element})[${counter}]    
            Click Element    (${element})[${counter}]
            ${product_name}    Get Element Attribute    ${product_title_xpath}    ${Attribute}
            ${product_name}    Fetch From Left    ${product_name}    ${split_str}
            ${product_prices}    Get Element Attribute    ${product_price}    ${Attribute}
            ${discount}    Get Element Attribute    ${new_discount_path}    ${Attribute}
            Set To Dictionary    ${deal_dict}    ${product_name}    price:${product_prices}, discount:${discount}
            Go Back            
        END    
    END
    Log    ${deal_dict}


*** Test Cases ***
Get Blockbuster Deals and Find Extremes
    Open Amazon Website
    Get All Blockbuster Deals
