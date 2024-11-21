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
${product_count_amazon_dy}    (//span[contains(@class, 'a-price-whole')])[1]

${amazon_product_name}    (//div[@data-cy="title-recipe"]//span[@class="a-size-medium a-color-base a-text-normal"])[1]

${Amazon_element_price}    (//span[@class="a-price-whole"])[1]
${amazon_delivery_date}    //div[@data-cy="delivery-recipe"]//span[@class="a-color-base a-text-bold"]
${amazon_delivery_date_dy}   (//div[@data-cy="delivery-recipe"]//span[@class="a-color-base a-text-bold"])[{index}]
${delivery_amazon}    (//span[@class="a-color-base"])[1]

# flipkart xpath
${product_count_flikart}    //div[@class="_75nlfW"]
${product_count_flikart_dy}       (//div[@class="_75nlfW"])[{index}]
# ${flipkart_product_name}    //div[@class="tUxRFH"]//div[@class="KzDlHZ"]
# ${flipkart_product_name_dy}   (//div[@class="tUxRFH"])[{index}]//div[@class="KzDlHZ"]
${flipkart_product_name}   //a[@class="wjcEIp"]
${flipkart_product_name_dy}    (//a[@class="wjcEIp"])[{index}]
${Flipkart_delivery_date}   //span[@class="Y8v7Fl"] 

# myntra
${myntra_product_count}    //h3[@class="product-brand"]/parent::div
${myntra_product_count_dy}    (//h3[@class="product-brand"]/parent::div)[1]
${myntra_price}    //span[@class="product-discountedPrice"]
${myntra_price_dy}    (//span[@class="product-discountedPrice"])[1]

${myntra_delivery_search_inp}    //input[@placeholder="Enter pincode"]
${myntra_del_check_btn}    //input[@type="submit"]
${myntra_del_date}    //li[@class="pincode-serviceabilityItem"]//h4[contains(text(),'Get it by')]
${pincode}    600103
${Attribute}    innerText
${commo}       ,
${dot}    .
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
    ${amazon_list}     Create List
        Wait Until Page Contains Element    ${product_count_amazon_dy}    10s
        ${name_of_the_item_amazon}    Get Element Attribute   ${amazon_product_name}      innerText
        ${formatted_name}    Fetch From Left    ${name_of_the_item_amazon}    ,

        Wait Until Page Contains Element    ${Amazon_element_price}    10s
        ${price_amazon}    Get Element Attribute    ${Amazon_element_price}       innerText
        ${formatted_price}    Remove String    ${price_amazon}    ,
        Wait Until Page Contains Element   ${delivery_amazon}    10s
        ${delivery_date_amazon}    Get Element Attribute    ${delivery_amazon}    innerText
    
        ${amazon_dict}    Create Dictionary    name=${formatted_name}       price=${formatted_price}    delivery=${delivery_date_amazon}
        Append To List    ${amazon_list}    ${amazon_dict}

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

#    ${myntra_ele_count}    Get Element Count    ${myntra_product_count}
    ${myntra_item_list}    Create List
    # FOR    ${counter}    IN RANGE    1    ${myntra_ele_count} 
        
        # ${myntra_item_name}    Format String    ${myntra_product_count_dy}    index=${counter}   
        Wait Until Page Contains Element    ${myntra_product_count_dy}    10s
        ${name_of_the_item_myntra}    Get Element Attribute    ${myntra_product_count_dy}       ${Attribute}   
        
        # ${myntra_item_price}    Format String    ${myntra_price}    index=${counter}   
        Wait Until Page Contains Element    ${myntra_price}    10s
        ${price_of_the_item_myntra}    Get Element Attribute    ${myntra_price}       ${Attribute}        
        
        ${formatted_price}    Fetch From Right    ${name_of_the_item_myntra}    ${dot}

        Wait Until Page Contains Element    ${myntra_product_count_dy}
        Click Element    ${myntra_product_count_dy}

        Switch Window     New
        Wait Until Page Contains Element    ${myntra_delivery_search_inp}    10s
        Execute Javascript    window,scrollTo(0,500)
        Run Keyword And Ignore Error    Input Text    ${myntra_delivery_search_inp}    ${pincode}
        Run Keyword And Ignore Error    Click Element   ${myntra_del_check_btn}
        
        Wait Until Page Contains Element    ${myntra_del_date}    10s
        ${myntra_order_date}    Get Element Attribute    ${myntra_del_date}    ${Attribute}
        ${formatted_myntra_date}    Fetch From Right     ${myntra_order_date}    by 
        ${formatted_price}    Remove String    ${formatted_myntra_date}    ${commo}

        ${window_tabs}    Get Window Handles    
        Switch Window    ${window_tabs[0]}    

        ${myntra_dict}    Create Dictionary    name=${name_of_the_item_myntra}    price=${price_of_the_item_myntra}    delivery=${formatted_myntra_date}
        Append To List    ${myntra_item_list}      ${myntra_dict}  
        

        Capture Page Screenshot

    # END
    Log    ${myntra_item_list}




Compare Product Rates Across Platforms
    [Arguments]    ${product_name}
    Input Product Name    ${product_name}
    Search Product On Amazon    ${product_name}
    # ${price_flipkart}    ${delivery_flipkart}    Search Product On Flipkart    ${product_name}
    Search Product On Myntra    ${product_name}


*** Test Cases ***
tc01    
    
    Compare Product Rates Across Platforms   earpods 