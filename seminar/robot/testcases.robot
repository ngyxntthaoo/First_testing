*** Settings ***
Documentation     A test suite containing tests for website random.org
Suite Setup       Open Browser To Main Page
Suite Teardown    Close Browser
Resource          resource.robot


*** Test Cases ***
Default
    Generate Random Number
Negative Input
    Generate Random Number  -123    -1
Equal Input
    Generate Random Number  0       0
Invalid Input
    Generate Random Number  invalid     1
    Generate Random Number  0       invalid
    
*** Variables ***
${current min}      ${DEFAULT MIN}
${current max}      ${DEFAULT MAX}

*** Keywords ***
	
Span should be loaded
	[Arguments]		${xpath}
	Page Should Contain Element    ${xpath}
    
Input Min
    [Arguments]    ${Min}
    Unselect Frame
    Select Frame	xpath://div[@id="homepage-generator"]//iframe
    ${path} =   Set Variable    xpath://html//body//div//span[2]//input
    Span should be loaded       ${path}
    ${IDmin} =  Get Element Attribute     ${path}    id
    Input Text    ${IDmin}    ${Min}
    
    Set Test Variable   ${current IDmin}    ${IDmin}
    Unselect Frame
	

Input Max
    [Arguments]    ${Max}
    Unselect Frame
    Select Frame	xpath://div[@id="homepage-generator"]//iframe
    ${path} =   Set Variable    xpath://html//body//div//span[3]//input
    Span should be loaded       ${path}
    ${IDmax} =  Get Element Attribute     ${path}    id
    Input Text    ${IDmax}    ${Max}
    Set Test Variable   ${current IDmax}    ${IDmax}
    Unselect Frame

Generate Number
    Unselect Frame
    Select Frame	xpath://div[@id="homepage-generator"]//iframe
    ${path} =   Set Variable    xpath://html//body//div//span[4]//input
    Span should be loaded       ${path}
    ${IDsubmit} =  Get Element Attribute     ${path}    id
    Click Button    ${IDsubmit}
    ${path} =   Set Variable    xpath://html//body//div//span[5]//center//span[1]
    Wait Until Page Contains Element    ${path}     5
    ${text} =   Get Text    ${path}
    
    ${value} =  Get Value   ${current IDmin}
    Set Test Variable    ${current min}   ${value}
    
    ${value} =  Get Value   ${current IDmax}
    Set Test Variable    ${current max}   ${value}
    
    Log To Console      ${current min} ${text} ${current max}
    Should Be True      ${current min} <= ${text}
    Should Be True      ${text} <= ${current max}
    Unselect Frame
    
 Generate Random Number
    [Arguments]     ${Min}=${DEFAULT MIN}      ${Max}=${DEFAULT MAX}
    Input Min       ${Min}
    Input Max       ${Max}
    Generate Number
