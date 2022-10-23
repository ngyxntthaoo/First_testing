*** Settings ***
Library  String
Resource  resource.robot

*** Variables ***

${Result}    ${False}
${username}  ${EMPTY}
${password}  ${EMPTY}

# windows
${formHome}  /Window[@AutomationId='FormHome']
${formAccount}  ${formHome}/Window[@AutomationId="FormAccount"]

# dialogs
${accCreated}  ${formAccount}/Window/Text[@Name="Account created!"]
${invalid iden}  ${formAccount}/Window/Text[@Name="Invalid Identification"]

# buttons
${btnSearch}  ${formHome}/Pane[@AutomationId="panel1"]/Button[@AutomationId="btnSearch"]
${btnAccount}  ${formHome}/Pane[@AutomationId="searchDropDown1"]/Pane[@AutomationId="flowLayoutPanel1"]/Button[@AutomationId="btnAccount"]
${btn_add_account}  ${formAccount}/Button[@AutomationId="btn_add_account"]

# textboxes
${tb_username}  ${formAccount}/Edit[@AutomationId="tb_username"]
${tb_password}  ${formAccount}/Edit[@AutomationId="tb_password"]
${tb_name}  ${formAccount}/Edit[@AutomationId="tb_name"]
${tb_iden}  ${formAccount}/Edit[@AutomationId="tb_iden"]

*** Keywords ***
Test Setup
    ${Result}  Run Keyword And Return Status  Element Should Be Visible  ${formAccount}  
    Run Keyword If  ${Result} == ${False}  Open Account Form

Add Account
    [Arguments]    ${user}=""    ${pass}=""    ${name}=""    ${iden}="123456789012"
    [Documentation]    A keyword for adding a new account
    ...                with username and password
    ...                if empty, username and password will be generated
    ...                name and identification are optional
    [Tags]    Account
    ${random} =  Generate Random String  10
    ${user} =  Set Variable If  ${user} == ""  ${random}  ${user}
    ${pass} =  Set Variable If  ${pass} == ""  ${random}  ${pass}
    Set Test Variable  ${username}  ${user}
    Set Test Variable  ${password}  ${pass}
    Press Key  t'${username}'  ${tb_username}
    Press Key  t'${password}'  ${tb_password}
    Press Key  t'${name}'  ${tb_name}
    Press Key  t'${iden}'  ${tb_iden}
    Click  ${btn_add_account}

Open Account Form
    [Documentation]    A keyword for opening the account form
    [Tags]    Account
    ${Result}  Run Keyword And Return Status  Element Should Be Visible  ${btnAccount}  ${False}
    Run Keyword If  ${Result} == ${False}  Open Search Dropdown
    Click  ${btnAccount}
    Wait Until Element Is Visible  ${formAccount}
    ${current_window}  Set Global Variable  ${formAccount}

Open Search Dropdown
    [Documentation]    A keyword for opening the search dropdown
    [Tags]    Search
    Click  ${btnSearch}
    ${Result}  Run Keyword And Return Status  Element Should Be Visible  ${btnAccount}  ${False}
    Run Keyword If  ${Result} == ${False}  Open Search Dropdown
