*** Settings ***

Library    SeleniumLibrary

*** Variables ***

*** Test Cases ***

tccc
    Open Browser    https://www.geeksforgeeks.org/what-is-machine-learning/?ref=shm    gc
    Maximize Browser Window
    Sleep    3

    Wait Until Page Contains Element    //span[text()='Practice']
    Mouse Over    //span[text()='Practice']
    # Click Element    //span[text()='Practice']

    Sleep    3
    Wait Until Page Contains Element    //li[contains(@class,"mega-dropdown__list-item")]/span[text()="Practice Problems Difficulty Wise"]
    Mouse Over   //li[contains(@class,"mega-dropdown__list-item")]/span[text()="Practice Problems Difficulty Wise"]

    Wait Until Page Contains Element    //li[contains(@class,"mega-dropdown__list-item")]/span[text()="Practice Problems Difficulty Wise"]/parent::li/ul/li/a[text()="Hard"]
    Click Element    //li[contains(@class,"mega-dropdown__list-item")]/span[text()="Practice Problems Difficulty Wise"]/parent::li/ul/li/a[text()="Hard"]
    Sleep    2
    Capture Page Screenshot