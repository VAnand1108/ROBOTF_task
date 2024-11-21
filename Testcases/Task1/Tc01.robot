*** Settings ***
Library    SeleniumLibrary
Library    builtin
Library    String
Library    Collections
Variables    ../../Datas/data.py
Variables    ../../Datas/xpath.py
Resource    ../../Testcases/Task1/TC01_support.robot


*** Test Cases ***
Amazon 5G Mobile Under 10000. 
    [Documentation]    This Testcase is to Log the Product Details Which are under 10k.
    Given open the amazon app    ${amazon_url}    ${browser}
    When searching the amazon product
    Then Get Mobile Details