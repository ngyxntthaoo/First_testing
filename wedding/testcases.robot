*** Settings ***
Documentation     A test suite containing tests for app wedding management

Resource          resource.robot


*** Test Cases ***
Application Should Exist
    Attach Application
    
Enter Username
    Press Key    t'123'    /Window[@AutomationId='FormLogin']/Pane[1]/Edit[2]
    Press Key    t'123'    /Window[@AutomationId='FormLogin']/Pane[1]/Edit[1]
    Click    /Window[@AutomationId='FormLogin']/Pane[1]/Button

*** Variables ***

*** Keywords ***