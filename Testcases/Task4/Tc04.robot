*** Settings ***
Library    SeleniumLibrary
Library    builtin
Library    String
Library    Collections
Variables    ../../Datas/data.py
Variables    ../../Datas/xpath.py
Resource    ../../Testcases/Task4/TC04_support.robot


*** Test Cases ***
Amazon highest 100 Mobile sorting price
    Given open the amazon app
    When searching the amazon product
    Then Get Product Details
    Then top 15 product filter with price
