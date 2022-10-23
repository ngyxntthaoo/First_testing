*** Settings ***
Documentation     A test suite containing tests for app wedding management
Test Setup       Run Keywords  Attach Application  AND  Log In  123  123  AND  Test Setup
Resource          resource.robot
Resource          account_resource.robot
Test Teardown    Shutdown Application

*** Test Cases ***
Add Valid Account
    [Documentation]    A test case for adding a new account
    ...                with valid data
    ...                and checking if the account is added
    ...                by logging out and logging in using the new account
    [Tags]    Account    Add    Valid
    Add Account
    Element Should Be Visible  ${accCreated}  Failed to add account, the account might has already existed, or the data is invalid
    Shutdown Application
    Attach Application
    Log In  ${username}  ${password}
    Element Should Be Visible  ${formHome}

Add Invalid Account With Invalid Identification
    [Documentation]    A test case for adding a new account
    ...                with invalid identification
    ...                and checking if the account is not added
    ...                by looking at the error message
    [Tags]    Account    Add    Invalid
    ${randomiden}  Generate Random String  12
    Add Account  iden=${randomiden}
    Element Should Be Visible  ${invalid iden}  Account added with invalid identification

Add Invalid Account With Invalid Identification
    [Documentation]    A test case for adding a new account
    ...                with invalid identification
    ...                and checking if the account is not added
    ...                by looking at the error message
    [Tags]    Account    Add    Invalid
    ${randomiden}  Generate Random String  3
    Add Account  iden=${randomiden}
    Element Should Be Visible  ${invalid iden}  Account added with invalid identification

