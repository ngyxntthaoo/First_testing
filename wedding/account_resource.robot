*** Settings ***
Library  String
Resource  resource.robot

*** Variables ***

${Result}    ${False}
${username}  ${EMPTY}
${password}  ${EMPTY}

# windows
${formAccount}  ${formHome}/Window[@AutomationId="FormAccount"]

# dialogs
${accCreated}  ${formAccount}/Window/Text[@Name="Account created!"]
${invalid iden}  ${formAccount}/Window/Text[@Name="Invalid Identification"]
${accDeleted}  ${formAccount}/Window/Text[@Name="Account deleted!"]
${username_pls}  ${formAccount}/Window/Text[@Name="Please enter username"]
${accExisted}  ${formAccount}/Window/Text[@Name="Username already exists!"]

# buttons
${btnAccount}  ${formHome}/Pane[@AutomationId="searchDropDown1"]/Pane[@AutomationId="flowLayoutPanel1"]/Button[@AutomationId="btnAccount"]
${btn_add_account}  ${formAccount}/Button[@AutomationId="btn_add_account"]
${btn_update_account}  ${formAccount}/Button[@AutomationId="btn_update_account"]
${btn_delete_account}  ${formAccount}/Button[@AutomationId="btn_delete_account"]

# textboxes
${tb_search}  ${formAccount}/Edit[@AutomationId="tb_search"]
${tb_username}  ${formAccount}/Edit[@AutomationId="tb_username"]
${tb_password}  ${formAccount}/Edit[@AutomationId="tb_password"]
${tb_name}  ${formAccount}/Edit[@AutomationId="tb_name"]
${tb_iden}  ${formAccount}/Edit[@AutomationId="tb_iden"]

# tables
${table_accounts}  ${formAccount}/Table[@AutomationId="gv_act"]

*** Keywords ***
Test Setup
    ${Result}  Run Keyword And Return Status  Element Should Be Visible  ${formAccount}  
    Run Keyword If  ${Result} == ${False}  Open Account Form

Add Account
    [Arguments]    ${user}=""    ${pass}=""    ${name}=""    ${iden}="123456789012"  ${level}=3
    [Documentation]    A keyword for adding a new account
    ...                with username and password
    ...                if empty, username and password will be generated
    ...                name and identification are optional
    [Tags]    Account
    ${random} =  Generate Random String  10
    ${user} =  Set Variable If  "${user}" == ""  ${random}  ${user}
    ${pass} =  Set Variable If  "${pass}" == ""  ${random}  ${pass}
    Set Test Variable  ${username}  ${user}
    Set Test Variable  ${password}  ${pass}
    Press Key  t'${username}'  ${tb_username}
    Press Key  t'${password}'  ${tb_password}
    Press Key  t'${name}'  ${tb_name}
    Press Key  t'${iden}'  ${tb_iden}
    Click  ${formAccount}/ComboBox[@AutomationId="cbb_level"]/Button
    Click  ${formAccount}/ComboBox[@AutomationId="cbb_level"]/List/ListItem[${level}]
    Click  ${btn_add_account}

Open Account Form
    [Documentation]    A keyword for opening the account form
    [Tags]    Account
    ${Result}  Run Keyword And Return Status  Element Should Be Visible  ${btnAccount}  ${False}
    Run Keyword If  ${Result} == ${False}  Open Search Dropdown
    Click  ${btnAccount}
    Wait Until Element Is Visible  ${formAccount}
    ${current_window}  Set Global Variable  ${formAccount}

Search Account
    [Arguments]  ${string to search}
    [Documentation]    A keyword for searching an account
    ...                This keyword return True when all the accounts
    ...                in the table contain the string to search
    ...                in their username, name or identification
    ...                If the table contains no accounts, it will also return True
    ...                This keyword return False when there is at least
    ...                one account that does not contain the string to search
    # if string to search is empty then don't press key
    Run Keyword If  "${string to search}" != ""  Press Key  t'${string to search}'  ${tb_search}
    Press Key  s'ENTER'
    ${continue}  Set Variable  ${True}
    ${wrong}  Set Variable  ${False}
    ${i}  Set Variable  0
    Select Closest Selectable  ${table_accounts}  Username
    WHILE  ${continue}
        ${condition 1}  Element Should Exist  ${table_accounts}/Custom[@Name="Row ${i}"]
        IF  ${condition 1}
            ${us}  Get Text From Textbox  ${table_accounts}/Custom[@Name="Row ${i}"]/Edit[@Name="Username Row ${i}, Not sorted."]
            ${name}  Get Text From Textbox  ${table_accounts}/Custom[@Name="Row ${i}"]/Edit[@Name="Name Row ${i}, Not sorted."]
            ${iden}  Get Text From Textbox  ${table_accounts}/Custom[@Name="Row ${i}"]/Edit[@Name="Identification Row ${i}, Not sorted."]
            ${condition 2}  Run Keyword And Return Status  Should Contain  ${us}  ${string to search}
            ${condition 3}  Run Keyword And Return Status  Should Contain  ${name}  ${string to search}
            ${condition 4}  Run Keyword And Return Status  Should Contain  ${iden}  ${string to search}
            IF  ${condition 2} or ${condition 3} or ${condition 4}
                No Operation
            ELSE
                ${continue}  Set Variable  ${False}
                ${wrong}  Set Variable  ${True}
            END
        ELSE
            ${continue}  Set Variable  ${False}
        END
        Press Key  s'DOWN'
        ${i}  Evaluate  ${i} + 1
    END
    Should Not Be True  ${wrong}  Found account with wrong data
    