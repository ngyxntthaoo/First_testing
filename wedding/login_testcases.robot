*** Settings ***
Documentation     A test suite containing tests for app wedding management
Test Setup        Attach Application
Resource          resource.robot
Test Teardown     Shutdown Application


*** Test Cases ***
LOGID01
    Log In    123    123
    Element Should Be Visible    ${FormHome}

LOGID02
    Log In    123    123@bc
    Element Should Be Visible    ${WrongPasswordDialog}

LOGID03
    Log In    invalid    123
    Element Should Be Visible    ${WrongUsernameDialog}


LOGID04
    Log In    Azx@12  123@bc
    Element Should Be Visible    ${InformationIsNotCreatedDialog}

*** Variables ***
${WrongUsernameDialog}    /Window[@AutomationId='FormLogin']/Window/Text[@Name='Wrong username']
${WrongPasswordDialog}    /Window[@AutomationId='FormLogin']/Window/Text[@Name='Wrong password']
${InformationIsNotCreatedDialog}    /Window[@AutomationId='FormLogin']/Window/Text[@Name='Information is not created']
${FormHome}    /Window[@AutomationId='FormHome']

*** Keywords ***