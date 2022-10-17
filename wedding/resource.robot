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

# This is a keyword that can be used to start the application under test.
# It is a good idea to use a keyword for this, because it can be used
# in multiple test cases.
Attach Application
    ${pid}    Launch Application    ${path}
    Set Suite Variable    ${PID}    ${pid}
    Attach Application By PID    ${pid}

Shutdown Application
    Close Application    ${PID}

