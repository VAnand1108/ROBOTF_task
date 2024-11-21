*** Settings ***
Library    SeleniumLibrary
Library    BuiltIn
Library    String
Library    Collections
Variables    ../../Datas/data.py
Variables    ../../Datas/xpath.py
Resource    ../../Testcases/Task3/tc03_support.robot

*** Variables ***
${user}    iphone
${price_xpath_template}    //div[contains(@class,'rush-component s-featured-result-item')]//span[@class='a-price-whole'][normalize-space()='{}']
${product_count}    //div[@data-component-type="s-search-result"]
${product}    (//div[@data-component-type="s-search-result"])[{counts}]
${Attribute}    innerText
${product_tab}    (//div[@data-component-type="s-search-result"]//h2[@class="a-size-mini a-spacing-none a-color-base s-line-clamp-2"]/a)[{link}]
${mobile_name}    //span[@id='productTitle']
${mobile_title2}    //h1[@id="title"]
${mobile_price}     (//div[@data-component-type="s-search-result"]//span[@class="a-price-whole"])[{counts}]
${commas}    ,
${product_disc}    //div[@id="corePriceDisplay_desktop_feature_div"]//span[@class="a-size-large a-color-price savingPriceOverride aok-align-center reinventPriceSavingsPercentageMargin savingsPercentage"]
${emi}    //div[@id="inemi_feature_div"]//span[2]

*** Keywords ***
Open Amazon Website
    [Documentation]    Opens Amazon and maximizes the browser window
    Open Browser    https://www.amazon.in    chrome
    Maximize Browser Window
    Sleep    5

search the product
    [Arguments]    ${product}
    [Documentation]    Search for the product and press ENTER
    Input Text    //*[@id="twotabsearchtextbox"]    ${product}
    Press Keys    //*[@id="twotabsearchtextbox"]    ENTER
    Sleep    5
    Capture Page Screenshot

Check Mobile Counts and Validate
    [Documentation]    Loop through all products and fetch details if price is >= 10000
       
    ${product_dict}    Create Dictionary
    ${count}    Get Element Count    ${product_count}
    
    FOR    ${counter}    IN RANGE    1    ${count}+1
        ${product_prices}    Format String    ${mobile_price}    counts=${counter}
        ${product_prices_text}    Get Text    ${product_prices}

        # Remove commas from price and convert to integer
        ${price}    Replace String    ${product_prices_text}    ${commas}    ${EMPTY}
        ${price}    Convert To Integer    ${price}
        
        IF    ${price} >= 10000
            ${product_tab_xpath}    Format String    ${product_tab}    link=${counter}
            Click Element    ${product_tab_xpath}
            Sleep    2
            Switch Window    NEW

            # Fetch mobile model name
            ${Wait}    Run Keyword And Return Status    Wait Until Element Is Visible    ${mobile_name}    10s
            IF    ${Wait}
                ${model_name}    Get Text    ${mobile_name}
            ELSE
                ${model_name}    Get Text    ${mobile_title2}
            END

            # Fetch discount if available
            ${discount_exists}    Run Keyword And Return Status    Element Should Be Visible    ${product_disc}
            IF    ${discount_exists}
                ${discount}    Get Text    ${product_disc}
            ELSE
                ${discount}    Set Variable    N/A
            END

            # Fetch EMI details
            ${emi_exists}    Run Keyword And Return Status    Element Should Be Visible    ${emi}
            IF    ${emi_exists}
                ${product_emi}    Get Text    ${emi}
            ELSE
                ${product_emi}    Set Variable    No EMI available
            END

            # Store product details in dictionary
            Set To Dictionary    ${product_dict}    ${model_name}    {"Price": ${price}, "Discount": ${discount}, "EMI": ${product_emi}}

            # Close the current tab and switch back to the main tab
            Close Window
            Switch Window    MAIN
        END
    END
    Log    ${product_dict}

*** Test Cases ***
tc05
    Open Amazon Website
    search the product    ${user}
    Check Mobile Counts and Validate
    [Teardown]    Close Browser
