*** Settings ***
Documentation    A test suite containing tests for the home page of the
...              app Wedding Management
Resource    resource.robot
Suite Setup    Run Keywords  Attach Application  AND  Log In  123  123
Suite Teardown    Shutdown Application

*** Test Cases ***
Click All Buttons In The Home Page
    Open Search Dropdown
    Open Lobby Dropdown
    Open Menu Window
    Close Menu Window
    Open Service Window
    Close Service Window
    Open Wedding Window
    Close Wedding Window
    Open Report Dropdown
    Open Settings Window
    ENTER
    Log Out