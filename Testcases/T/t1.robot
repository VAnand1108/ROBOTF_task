*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    DateTime
Library    String

*** Variables ***
${platforms}    Amazon    Flipkart    Myntra
${urls}    https://www.amazon.in/    https://www.flipkart.com/    https://www.myntra.com/
${search_box_xpaths}    //input[@id='twotabsearchtextbox']    //input[@name='q']    //input[@placeholder='Search']
${price_xpaths}    //span[contains(@class, 'a-price-whole')]    //div[contains(@class,'Nx9bqj _4b5DiR')]    //span[contains(@class, 'product-discountedPrice')]
${delivery_xpaths}    //span[contains(text(), 'Delivery')]    //span[contains(text(), 'Delivery')]    //div[contains(@class, 'estimated-delivery')]

*** Keywords ***

Search Product On Platform
    [Arguments]    ${platform}    ${product_name}
    ${index}    Get Index From List    ${platforms}    ${platform}
    ${url}    Get From List    ${urls}    ${index}
    ${search_box_xpath}    Get From List    ${search_box_xpaths}    ${index}
    ${price_xpath}    Get From List    ${price_xpaths}    ${index}
    ${delivery_xpath}    Get From List    ${delivery_xpaths}    ${index}

    Open Browser    ${url}    chrome
    Maximize Browser Window
    Wait Until Page Contains Element    ${search_box_xpath}    10s
    Input Text    ${search_box_xpath}    ${product_name}
    Press Keys    ${search_box_xpath}    ENTER

    Wait Until Page Contains Element    ${price_xpath}    10s
    ${price}    Get Text    ${price_xpath}
    ${price}    Remove String    ${price}    ,  # Remove commas

    Wait Until Page Contains Element    ${delivery_xpath}    10s
    ${delivery}    Get Text    ${delivery_xpath}

    Log    Price on ${platform}: ${price}
    Log    Delivery on ${platform}: ${delivery}
    Close Browser
    [Return]    ${price}    ${delivery}

Convert Delivery Days
    [Arguments]    ${delivery_text}
    ${delivery_days}    Evaluate    0
    IF    'days' in ${delivery_text}
        ${delivery_days}    Evaluate    int(re.findall(r'\d+', '${delivery_text}')[0])
    ELSE
        Log    Unable to determine delivery date, assuming beyond 7 days.
        ${delivery_days}    Set Variable    999  # Arbitrarily large number for invalid date
    END
    [Return]    ${delivery_days}

Compare Prices And Delivery
    [Arguments]    ${prices}    ${deliveries}
    
    ${delivery_amazon_days}    Convert Delivery Days    ${deliveries[0]}
    ${delivery_flipkart_days}    Convert Delivery Days    ${deliveries[1]}
    ${delivery_myntra_days}    Convert Delivery Days    ${deliveries[2]}
    
    ${min_price}    Evaluate    min(${prices[0]}, ${prices[1]}, ${prices[2]})
    ${best_platform}    Set Variable    None

    IF    '${min_price}' == '${prices[0]}' AND ${delivery_amazon_days} <= 7
        ${best_platform}    Set Variable    Amazon
    ELSE IF    '${min_price}' == '${prices[1]}' AND ${delivery_flipkart_days} <= 7
        ${best_platform}    Set Variable    Flipkart
    ELSE IF    '${min_price}' == '${prices[2]}' AND ${delivery_myntra_days} <= 7
        ${best_platform}    Set Variable    Myntra
    END

    Log    Best platform is ${best_platform} with price ${min_price} and delivery within 7 days.

*** Test Cases ***
tc01    
    ${product_name}    Set Variable    earpods
    ${prices}    Create List
    ${deliveries}    Create List

    FOR    ${platform}    IN    @{platforms}
        ${price}    ${delivery}    Search Product On Platform    ${platform}    ${product_name}
        Append To List    ${prices}    ${price}
        Append To List    ${deliveries}    ${delivery}
    END

    Compare Prices And Delivery    ${prices}    ${deliveries}
