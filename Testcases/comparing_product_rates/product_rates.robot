*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    DateTime
Library    String
# Library    RPA.SAP

*** Variables ***
${amazon_url}    https://www.amazon.in/
${flipkart_url}    https://www.flipkart.com/
${myntra_url}    https://www.myntra.com/
${search_box_xpath_amazon}    //input[@id='twotabsearchtextbox']
${search_box_xpath_flipkart}    //input[@name='q']
${search_box_xpath_myntra}    //input[@placeholder='Search']
${product_count_amazon}    //span[contains(@class, 'a-price-whole')]
${product_count_amazon_dy}    (//span[contains(@class, 'a-price-whole')])[{index}]

${amazon_product_name}    (//div[@data-cy="title-recipe"]//span[@class="a-size-medium a-color-base a-text-normal"])[{index}]


${amazon_delivery_date}    //div[@data-cy="delivery-recipe"]//span[@class="a-color-base a-text-bold"]
${amazon_delivery_date_dy}   (//div[@data-cy="delivery-recipe"]//span[@class="a-color-base a-text-bold"])[{index}]


# flipkart xpath
${product_count_flikart}    //div[@class="_75nlfW"]
${product_count_flikart_dy}       (//div[@class="_75nlfW"])[{index}]
# ${flipkart_product_name}    //div[@class="tUxRFH"]//div[@class="KzDlHZ"]
# ${flipkart_product_name_dy}   (//div[@class="tUxRFH"])[{index}]//div[@class="KzDlHZ"]
${flipkart_product_name}   //a[@class="wjcEIp"]
${flipkart_product_name_dy}    (//a[@class="wjcEIp"])[{index}]
${Flipkart_delivery_date}   //span[@class="Y8v7Fl"] 

# myntra


*** Keywords ***

Input Product Name
    [Arguments]    ${product_name}
    Log    Searching for product: ${product_name}

Search Product On Amazon
    [Arguments]    ${product_name}
    Open Browser    ${amazon_url}    chrome
    Maximize Browser Window
    Wait Until Page Contains Element    ${search_box_xpath_amazon}    10s
    Input Text    ${search_box_xpath_amazon}    ${product_name}
    Press Keys    ${search_box_xpath_amazon}    ENTER
    
    ${amazon_list}    Create List
    ${element_count}    Get Element Count    ${product_count_amazon}

    FOR    ${counter}    IN RANGE    1    ${element_count}

        ${amazon_item_name}    Format String    ${amazon_product_name}    index=${counter}   
        Wait Until Page Contains Element    ${amazon_item_name}    10s
        ${name_of_the_item_amazon}    Get Element Attribute    ${amazon_item_name}       innerText
        
        ${formatted_name}    Fetch From Left    ${name_of_the_item_amazon}    ,
        

        ${A_element_price}    Format String    ${product_count_amazon_dy}    index=${counter}   
        Wait Until Page Contains Element    ${A_element_price}    10s
        ${price_amazon}    Get Element Attribute    ${A_element_price}       innerText
        ${formatted_price}    Remove String    ${price_amazon}    ,

        
        ${delivery_amazon}    Format String    ${amazon_delivery_date_dy}    index=${counter}
        Wait Until Page Contains Element   ${delivery_amazon}    10s
        ${delivery_date_amazon}    Get Element Attribute    ${delivery_amazon}    innerText
    
        ${amazon_dict}    Create Dictionary    name=${formatted_name}       price=${formatted_price}    delivery=${delivery_date_amazon}
        Append To List    ${amazon_list}    ${amazon_dict}


    END
    Log    ${amazon_list}


Search Product On Flipkart
    [Arguments]    ${product_name}
    Open Browser    ${flipkart_url}    chrome
    Maximize Browser Window
    Wait Until Page Contains Element    ${search_box_xpath_flipkart}    10s
    Input Text    ${search_box_xpath_flipkart}    ${product_name}
    Press Keys    ${search_box_xpath_flipkart}    ENTER

    ${flipkart_list}    Create List
    # Wait Until Page Contains Element     ${product_count_flikart}
    Sleep    3
    ${element_count}    Get Element Count    ${product_count_flikart}

    FOR    ${counter}    IN RANGE    1    ${element_count}

        ${flipkart_item_name}    Format String    ${flipkart_product_name_dy}    index=${counter}   
        Wait Until Page Contains Element    ${flipkart_item_name}    10s
        # Sleep    200s
        ${name_of_the_item_flikart}    Get Element Attribute    ${flipkart_item_name}    innerText
        
        ${formatted_name}    Fetch From Left    ${name_of_the_item_flikart}    ,
        

        ${flipkart_item_price}    Format String    ${product_count_flikart_dy}    index=${counter}   
        Wait Until Page Contains Element    ${flipkart_item_price}    10s
        ${price_flipkart}    Get Element Attribute    ${flipkart_item_price}    innerText
        ${formatted_price}    Remove String    ${price_flipkart}    ,

        Click Element    ${flipkart_item_name}


        Wait Until Page Contains Element   ${Flipkart_delivery_date}    10s
        ${delivery_date_amazon}    Get Element Attribute    ${Flipkart_delivery_date}    innerText
        Go Back
    
        ${flipkart_dict}    Create Dictionary    name=${formatted_name}       price=${formatted_price}    delivery=${delivery_date_amazon}
        Append To List    ${flipkart_list}    ${flipkart_dict}


    END
    Log    ${flipkart_list}
Search Product On Myntra
    [Arguments]    ${product_name}
    Open Browser    ${myntra_url}    chrome
    Maximize Browser Window
    Wait Until Page Contains Element    ${search_box_xpath_myntra}    10s
    Input Text    ${search_box_xpath_myntra}    ${product_name}
    Press Keys    ${search_box_xpath_myntra}    ENTER
    Wait Until Page Contains Element    //span[contains(@class, 'product-discountedPrice')]    10s
    ${price_myntra}    Get Text    //span[contains(@class, 'product-discountedPrice')]    # First product price
    ${delivery_myntra}    Get Text    //div[contains(@class, 'estimated-delivery')]    # Delivery info
    Log    Price on Myntra: ${price_myntra}
    Log    Delivery on Myntra: ${delivery_myntra}

Compare Prices And Delivery
    [Arguments]    ${price_amazon}    ${delivery_amazon}    ${price_flipkart}    ${delivery_flipkart}    ${price_myntra}    ${delivery_myntra}
    
    ${min_price}    Evaluate    min(${price_amazon}, ${price_flipkart}, ${price_myntra})
    ${best_platform}    Set Variable    None

    IF    '${min_price}' == '${price_amazon}' AND '${delivery_amazon}' <= 7
        ${best_platform}    Set Variable    Amazon
    ELSE IF    '${min_price}' == '${price_flipkart}' AND '${delivery_flipkart}' <= 7
        ${best_platform}    Set Variable    Flipkart
    ELSE IF    '${min_price}' == '${price_myntra}' AND '${delivery_myntra}' <= 7
        ${best_platform}    Set Variable    Myntra
    END

    Log    Best platform is ${best_platform} with price ${min_price} and delivery within 7 days.


Compare Product Rates Across Platforms
    [Arguments]    ${product_name}
    Input Product Name    ${product_name}
    ${price_amazon}    ${delivery_amazon}    Search Product On Amazon    ${product_name}
    ${price_flipkart}    ${delivery_flipkart}    Search Product On Flipkart    ${product_name}
    ${price_myntra}    ${delivery_myntra}    Search Product On Myntra    ${product_name}
    Compare Prices And Delivery    ${price_amazon}    ${delivery_amazon}    ${price_flipkart}    ${delivery_flipkart}    ${price_myntra}    ${delivery_myntra}


*** Test Cases ***
tc01    
    
    Compare Product Rates Across Platforms   earpods 