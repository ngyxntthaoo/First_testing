*** Settings ***
Documentation     A test suite containing tests for app wedding management
Test Setup        Attach Application
Resource          resource.robot
Test Teardown     Shutdown Application


*** Test Cases ***
Log In With Valid Credentials Should Pass
    Log In    123    123
    Element Should Be Visible    ${FormHome}

Log In With Invalid Password Should Fail
    Log In    123    invalid
    Element Should Be Visible    ${WrongPasswordDialog}

Log In With Invalid Username Should Fail
    Log In    invalid    123
    Element Should Be Visible    ${WrongUsernameDialog}

*** Variables ***
${WrongUsernameDialog}    /Window[@AutomationId='FormLogin']/Window/Text[@Name='Wrong username']
${WrongPasswordDialog}    /Window[@AutomationId='FormLogin']/Window/Text[@Name='Wrong password']
${FormHome}    /Window[@AutomationId='FormHome']

*** Keywords ***