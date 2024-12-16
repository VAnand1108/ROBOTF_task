*** Settings ***
Library    SeleniumLibrary
Library    String
Library    Collections
Library    RPA.Excel.Files

*** Variables ***
${URL}                    https://www.browserstack.com/testimonials
${BROWSER}                 chrome
${ATTRIBUTE}               data
${ATTRIBUTE1}               innerText 

${img}    //section[@class="testimonials-list-habitat"]//following::div[@class="testimonial-list-block"]/object[contains(@data,"normal") and not(contains(@data,"dummy"))]
${img_dy}    (//section[@class="testimonials-list-habitat"]//following::div[@class="testimonial-list-block"]/object[contains(@data,"normal") and not(contains(@data,"dummy"))])[{index}]
${img_name_dy}    (//section[@class="testimonials-list-habitat"]//following::div[@class="testimonial-list-block"]/object[contains(@data,"normal") and not(contains(@data,"dummy"))])[{index}]/following-sibling::p


*** Keywords ***
images
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Sleep    3
    Create Workbook    Testcases/mock/img.xlsx
    ${image_count}    Get Element Count    ${img} 
    ${output dic}    Create Dictionary
    ${images_list}    Create List
    ${section_list}    Create List

    FOR    ${counter}    IN RANGE    1    ${image_count}+1
        ${formatted_img_xpath}    Format String    ${img_dy}    index=${counter}
        ${img}    Get Element Attribute    ${formatted_img_xpath}     ${ATTRIBUTE}
        
        ${formatted_name_xpath}    Format String    ${img_name_dy}    index=${counter}
        ${img_names}   Get Element Attribute    ${formatted_name_xpath}     ${ATTRIBUTE1}

        Append To List    ${images_list}    ${img}
        Append To List    ${section_list}    ${img_names}
        
        
    END
    Set To Dictionary     ${output dic}     images=${images_list}    names=${section_list}
    Append Rows To Worksheet    ${output dic}    header=True
    Save Workbook
    Log     ${output dic} 
*** Test Cases ***
tc01    
    images