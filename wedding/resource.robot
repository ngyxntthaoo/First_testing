#robot --argumentfile args.robot
*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               doMain specific language. They utilize keywords provided
...               by the imported SeleniumLibrary.
Library           FlaUILibrary

*** Variables ***
${name}           WeddingManagementApplication.exe
${path}           F:\\Github\\WeddingManagement\\WeddingManagementApplication\\WeddingManagementApplication\\bin\\Debug\\WeddingManagementApplication.exe
${PID}            0

*** Keywords ***
Attach Application
    ${pid}    Launch Application    ${path}
    Set Suite Variable    ${PID}    ${pid}
    Attach Application By PID    ${pid}

Shutdown Application
    Close Application    ${PID}

Log In
    [Arguments]    ${username}    ${password}
    Press Key    t'${username}'    /Window[@AutomationId='FormLogin']/Pane[1]/Edit[2]
    Press Key    t'${password}'    /Window[@AutomationId='FormLogin']/Pane[1]/Edit[1]
    Click    /Window[@AutomationId='FormLogin']/Pane[1]/Button