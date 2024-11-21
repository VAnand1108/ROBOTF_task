*** Settings ***
Library    SeleniumLibrary
Library    builtin
Library    String
Library    Collections
Variables    ../../Datas/data.py
Variables    ../../Datas/xpath.py




*** Keywords ***
open the amazon app
    [Documentation]    Launch the Application
    # [Arguments]       ${url}    ${browser}
    Open Browser    ${amazon_url}    ${browser}
    Maximize Browser Window
    Sleep    5
searching the amazon product
    [Documentation]    Input the 5g in the search box and select the 5G under 10000
        
    Wait Until Page Contains Element   ${mobile_label}
    Click Element   ${mobile_label}
    Capture Page Screenshot
    Scroll Element Into View    ${best_seller}
    Capture Page Screenshot
    Wait Until Page Contains Element    ${best_seller}    10s
    Click Element    ${best_seller}    


    Wait Until Element Is Visible    ${page_title}
    Capture Page Screenshot


Get Product Details

    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    Sleep    10
    Scroll Element Into View    ${scroll_down}
    Sleep    10
    ${product_count}    Get Element Count    ${over_all_count}

    Log To Console   ${product_count}


    ${product_dict}    Create Dictionary
    Set Global Variable    ${product_dict}

    FOR    ${counter}    IN RANGE    1    ${product_count}
        ${phone_container_element}    Format String    ${attribite_name_xpath}    count=${counter}
        ${name_of_product}    Get Element Attribute    ${phone_container_element}  ${Attribute}

        ${element_price}    Format String    ${attribite_price_xpath}    name=${name_of_product}
        ${product_pricee}    Run Keyword And Return Status    Get Element Attribute    ${element_price}   ${Attribute}
       IF    $product_pricee != True
           ${product_prices}   Set Variable    ${None}

       ELSE IF  ${product_pricee} == True  
           ${product_prices}    Get Element Attribute    ${element_price}   ${Attribute}
           ${product_prices}    Fetch From Right    ${product_prices}    ${dollar}
           ${product_prices}    Fetch From Left    ${product_prices}    ${dot}
           ${product_prices}    Replace String    ${product_prices}    ${commas}    ${EMPTY}
        #    ${product_prices}    Replace String    ${product_prices}    ${rupees}    ${EMPTY}
           ${product_prices_validate}  Run Keyword And Return Status  Convert To Integer    ${product_prices}
           IF    $product_prices_validate == True
               ${product_prices}    Convert To Integer    ${product_prices}
               Set To Dictionary    ${product_dict}    ${name_of_product}    ${product_prices}
           END
        END
        IF    ${product_count} == ${counter}
            Go to next page and get products
           
        END  
       
    END
    

    Log    ${product_dict}


Go to next page and get products
    
    Click Element    ${page2}
    Execute JavaScript    window.scrollTo(0, document.body.scrollHeight)
    Sleep    10
    # Set Window Size    1024    1400
    Scroll Element Into View    ${scroll_down2}
    Sleep    10
    ${product_count}    Get Element Count    over_all_count

    Log To Console   ${product_count}


    FOR    ${counter}    IN RANGE    1    ${product_count}
        ${phone_container_element}    Format String    ${attribite_name_xpath}    count=${counter}
        ${name_of_product}    Get Element Attribute    ${phone_container_element}  ${Attribute}

        ${element_price}    Format String    ${attribite_price_xpath}    name=${name_of_product}
        ${product_pricee}    Run Keyword And Return Status    Get Element Attribute    ${element_price}   ${Attribute}
       IF    $product_pricee != True
           ${product_prices}   Set Variable    ${None}

       ELSE IF  ${product_pricee} == True  
           ${product_prices}    Get Element Attribute    ${element_price}   ${Attribute}
           ${product_prices}    Fetch From Right    ${product_prices}    ${dollar}
           ${product_prices}    Fetch From Left    ${product_prices}    ${dot}
           ${product_prices}    Replace String    ${product_prices}    ${commas}    ${EMPTY}
        #    ${product_prices}    Replace String    ${product_prices}    ${rupees}    ${EMPTY}
           ${product_prices_validate}  Run Keyword And Return Status  Convert To Integer    ${product_prices}
           IF    $product_prices_validate == True
               ${product_prices}    Convert To Integer    ${product_prices}
               Set To Dictionary    ${product_dict}    ${name_of_product}    ${product_prices}
           END
        END
    END



top 15 product filter with price
    ${sorted_dict}    Evaluate    dict(sorted(${product_dict}.items(),key=lambda item:item[1],reverse=True)[:15])    modules=collections
    Log    ${sorted_dict}