*** Settings ***
Library    SeleniumLibrary
Library    builtin
Library    String
Library    Collections
Variables    ../../Datas/data.py
Variables    ../../Datas/xpath.py
Resource    ../../Testcases/Task3/tc03_support.robot





*** Test Cases ***

Test BrowserStack Pricing
    [Documentation]   
    Given Open BrowserStack Website
    When Navigate To Pricing
    Then Get Pricing For Different Users    
    Close Browser
