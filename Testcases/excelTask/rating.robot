*** Settings ***
Library    SeleniumLibrary
Library    String
Library    RPA.Windows
Library    RPA.PDF
Library    Collections
 
*** Variables ***
${url}    https://www.amazon.in/
${browser}     chrome
${search_box}    id=twotabsearchtextbox
${search_text}    t-shirts for men
${product_container}    //div[@data-component-type="s-search-result"]
${product_title}    (//div[@data-component-type="s-search-result"]//div[@data-cy="title-recipe"]/h2)[{name}]
${product_price}    (//div[@data-component-type="s-search-result"]//div[@data-cy="price-recipe"]//span[@class="a-price-whole"])[{index}]
${product_mrp}    (//div[@data-component-type="s-search-result"]//div[@data-cy="price-recipe"]//div[@class="a-section aok-inline-block"]//span[@class="a-price a-text-price"]/span[@class="a-offscreen"])[{counts}]
${Product_rating}    //div[@data-component-type="s-search-result"][{rate}]//div[@data-cy="reviews-block"]//span[@class="a-icon-alt"]
${value}    4
${dot}    .
${rupees}   ₹
${camas}    ,
${Attribute}    innerText
*** Keywords ***
Launch Application
    Open Browser    ${url}    ${browser}
    Maximize Browser Window
 
*** Test Cases ***
Tc1
    Launch Application
    Input Text    ${search_box}    ${search_text}
    Press Keys    ${search_box}    ENTER
    ${count}    Get Element Count    ${product_container}
    ${list}    Create List
    FOR    ${counter}    IN RANGE    1    ${count}+1    
        ${ratings}    Format String    ${Product_rating}    rate=${counter}
        ${prod_rates}   Run Keyword And Return Status    Get Element Attribute    ${ratings}    ${Attribute}
        IF    $prod_rates == True
            ${prod_rate}    Get Element Attribute    ${ratings}    ${Attribute}
            ${rating}    Fetch From Left    ${prod_rate}     ${SPACE}
            ${rating}    Fetch From Left    ${rating}    ${dot}
            ${rating}    Convert To Integer    ${rating}
            ${value}    Convert To Integer    ${value}
            IF    $rating >= $value
                ${title}    Format String    ${product_title}    name=${counter}
                ${Prod_title}    Get Element Attribute    ${title}    ${Attribute}
                ${price}    Format String   ${product_price}    index=${counter}
                ${prod_price}    Get Element Attribute    ${price}    ${Attribute}
                ${prod_price}    Set Variable    ${prod_price}.00
                ${MRP}    Format String    ${product_mrp}    counts=${counter}
                ${Prod_mrp}    Get Element Attribute    ${MRP}    ${Attribute}
                ${Prod_mrp}    Fetch From Right    ${Prod_mrp}    ${rupees}
                ${Prod_mrp}    Replace String    ${Prod_mrp}    ${camas}    ${EMPTY}
                ${Prod_mrp}    Set Variable    ${Prod_mrp}.00
                Append To List    ${list}    ${Prod_title}|${prod_price}|${Prod_mrp}
            END
        END
       
       
    END
    Log    ${list}
 
 
