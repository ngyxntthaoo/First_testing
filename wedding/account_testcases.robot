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

Update Account Username
    [Documentation]    A test case for updating an account username
    [Tags]    Account    Update
    ${newUsername}  Generate Random String  10
    ${selected cell}  Select Closest Selectable  ${table_accounts}  Username
    ${value}  Get Text From Textbox  ${selected cell}
    Press Key  t'${newUsername}'  ${tb_username}
    Click  ${btn_update_account}
    ${status}  Run Keyword And Return Status  Select Cell With Attribute And Value  ${table_accounts}  Username  ${value}
    Should Not Be True  ${status}  Account username not updated, or the updated value is equal to the old value

Delete Account
    [Documentation]    A test case for deleting an account
    [Tags]    Account    Delete
    ${selected cell}  Select Closest Selectable  ${table_accounts}  Username
    ${value}  Get Text From Textbox  ${selected cell}
    Click  ${btn_delete_account}
    Element Should Be Visible  ${accDeleted}  Account not deleted
    Press Key  s'ENTER'
    ${status}  Run Keyword And Return Status  Select Cell With Attribute And Value  ${table_accounts}  Username  ${value}
    Should Not Be True  ${status}  Account not deleted
    Shutdown Application
    Attach Application
    Log In  ${value}  ${value}
    Element Should Not Exist  ${formHome}  Account not deleted

Search Existing Account
    [Documentation]    A test case for searching an existing account
    [Tags]    Account    Search    Valid
    ${string to search}  Set Variable  123
    ${status}  Run Keyword And Return Status  Search Account  ${string to search}
    Should Be True  ${status}  Account found with non-existing search string

Search Non-Existing Account
    [Documentation]    A test case for searching a non-existing account
    [Tags]    Account    Search    Invalid
    ${string to search}  Set Variable  hdsgfjsgfjhsdgfuysdgfuysdgfutsdgfutgsutfgtyusd
    ${status}  Run Keyword And Return Status  Search Account  ${string to search}
    Should Be True  ${status}  Account found with non-existing search string