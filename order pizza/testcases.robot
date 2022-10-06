*** Settings ***
Documentation     A test suite containing tests for website order pizza
Suite Setup       Open Browser To Main Page
Test Teardown     Go To Main Page
Suite Teardown    Close Browser
Resource          resource.robot


*** Test Cases ***
Valid Login And Order Should Have Passed
    Enter Username And Password    ${VALID USERNAME}   ${VALID PASSWORD}
    Login Should Have Passed
    Input Text      quantity    1
    Click Element   submit_button
    Wait Until Element Is Visible   added_message   10 seconds
    
Valid Login But Invalid Order Should Have Failed
    Enter Username And Password    ${VALID USERNAME}   ${VALID PASSWORD}
    Login Should Have Passed
    Click Element   submit_button
    Wait Until Element Is Visible   quantity_modal  2 seconds
    
Invalid Login Should Have Failed
    Enter Username And Password    invalid     invalid
    Login Should Have Failed

*** Keywords ***
Enter Username And Password
    [Arguments]     ${Username}     ${Password}
    Input Text      user    ${Username}
    Input Password      password    ${Password}
    Click Element       login
    
    
Login Should Have Passed
    Title Should Be     Order Pizza
    
Login Should Have Failed
    Title Should Be     Login