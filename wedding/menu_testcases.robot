*** Settings ***
Documentation    A test suite containing tests for menu of the app
...              Wedding Management
Resource         resource.robot
Suite Setup      Run Keywords  Attach Application  AND  Log In  123  123
Test Setup       Open Menu Window
Test Teardown    Close Menu Window
Suite Teardown   Shutdown Application

*** Test Cases ***


