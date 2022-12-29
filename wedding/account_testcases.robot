*** Settings ***
Documentation     A test suite containing tests for app wedding management
Test Setup       Run Keywords  Attach Application  AND  Log In  123  123  AND  Test Setup
Resource         resource.robot
Resource         account_resource.robot
Test Teardown    Shutdown Application

*** Test Cases ***


AACID01
    ${randomuser}  Generate Random String  12
    ${randompass}  Generate Random String  12
    ${name}  Set Variable  Hoàng Vy
    ${iden}  Generate Random String  12  [NUMBERS]
    Add Account  user=${randomuser}  pass=${randompass}  name=${name}  iden=${iden}  level=2
    Element Should Be Visible  ${accCreated}  Failed to add account, the account might has already existed, or the data is invalid
    ENTER
    # search account in table
    ${status}  Run Keyword And Return Status  Select Cell With Attribute And Value  ${table_accounts}  Username  ${randomuser}
    Should Be True  ${status}  Account not added

AACID02
    ${randomuser}  Set Variable  123
    ${randompass}  Generate Random String  12
    ${name}  Set Variable  Hoàng Dương
    ${iden}  Generate Random String  12  [NUMBERS]
    Add Account  user=${randomuser}  pass=${randompass}  name=${name}  iden=${iden}  level=3
    Element Should Be Visible  ${accExisted}  Failed to add account, the account might has already existed, or the data is invalid
    ENTER
    # search account in table
    ${status}  Run Keyword And Return Status  Select Cell With Attribute And Value  ${table_accounts}  Username  ${randomuser}
    Should Be True  ${status}  Account not added

AACID03
    ${randomuser}  Generate Random String  12
    ${randompass}  Generate Random String  12
    ${name}  Set Variable  Hoàng Long
    Press Key  t'${randomuser}'  ${tb_username}
    Press Key  t'${randompass}'  ${tb_password}
    Press Key  t'${name}'  ${tb_name}
    Click  ${formAccount}/ComboBox[@AutomationId="cbb_level"]/Button
    Click  ${formAccount}/ComboBox[@AutomationId="cbb_level"]/List/ListItem[1]
    Click  ${btn_add_account}
    Element Should Be Visible  ${invalid iden}  Account Added with invalid identification

AACID04
    ${randomuser}  Generate Random String  12
    Press Key  t'${randomuser}'  ${tb_username}
    Click  ${formAccount}/ComboBox[@AutomationId="cbb_level"]/Button
    Click  ${formAccount}/ComboBox[@AutomationId="cbb_level"]/List/ListItem[1]
    
    Click  ${btn_add_account}
    Element Should Be Visible  ${accCreated}  Account not added
    
AACID05
    ${user}  Set Variable  123
    ${pass}  Generate Random String  12
    Press Key  t'${user}'  ${tb_username}
    Press Key  t'${pass}'  ${tb_password}
    Click  ${formAccount}/ComboBox[@AutomationId="cbb_level"]/Button
    Click  ${formAccount}/ComboBox[@AutomationId="cbb_level"]/List/ListItem[2]
    
    Click  ${btn_add_account}
    Element Should Be Visible  ${accExisted}  Account added

AACID06
    # username null
    ${pass}  Generate Random String  12
    ${name}  Set Variable  Hoàng Long
    ${iden}  Generate Random String  12  [NUMBERS]
    Press Key  t'${pass}'  ${tb_password}
    Press Key  t'${name}'  ${tb_name}
    Press Key  t'${iden}'  ${tb_iden}
    Click  ${formAccount}/ComboBox[@AutomationId="cbb_level"]/Button
    Click  ${formAccount}/ComboBox[@AutomationId="cbb_level"]/List/ListItem[3]
    
    Click  ${btn_add_account}
    Element Should Be Visible  ${username_pls}  Account added

UDACID01
    ${selected cell}  Select Closest Selectable  ${table_accounts}  Username
    ${newName}  Set Variable  Văn Hải
    ${newIden}  Generate Random String  12  [NUMBERS]
    Click  ${formAccount}/ComboBox[@AutomationId="cbb_level"]/Button
    Click  ${formAccount}/ComboBox[@AutomationId="cbb_level"]/List/ListItem[1]
    Press Key  t'${newName}'  ${tb_name}
    Press Key  t'${newIden}'  ${tb_iden}
    Click  ${btn_update_account}
    # search account in table
    ${status}  Run Keyword And Return Status  Select Cell With Attribute And Value  ${table_accounts}  Name  ${newName}
    Should Be True  ${status}  Account username not updated, or the updated value is equal to the old value

UDACID02
    # update username to random string, update name to Thúy Vân, random iden, Level 2
    ${selected cell}  Select Closest Selectable  ${table_accounts}  Username
    ${newUsername}  Generate Random String  12
    ${newName}  Set Variable  Thúy Vân
    ${newIden}  Generate Random String  12  [NUMBERS]
    Click  ${formAccount}/ComboBox[@AutomationId="cbb_level"]/Button
    Click  ${formAccount}/ComboBox[@AutomationId="cbb_level"]/List/ListItem[2]
    Press Key  t'${newUsername}'  ${tb_username}
    Press Key  t'${newName}'  ${tb_name}
    Press Key  t'${newIden}'  ${tb_iden}
    Click  ${btn_update_account}
    # search account in table
    ${status}  Run Keyword And Return Status  Select Cell With Attribute And Value  ${table_accounts}  Name  ${newName}
    Should Be True  ${status}  Account username not updated, or the updated value is equal to the old value

UDACID03
    # update username to 123, update name to "", random iden, level 1
    ${selected cell}  Select Closest Selectable  ${table_accounts}  Username
    ${newUsername}  Set Variable  123
    ${newIden}  Generate Random String  12  [NUMBERS]
    Click  ${formAccount}/ComboBox[@AutomationId="cbb_level"]/Button
    Click  ${formAccount}/ComboBox[@AutomationId="cbb_level"]/List/ListItem[1]
    Press Key  t'${newUsername}'  ${tb_username}
    Double Click  ${tb_name}
    Double Click  ${tb_name}
    Press Key  s'BACK'  ${tb_name}
    Press Key  t'${newIden}'  ${tb_iden}
    Click  ${btn_update_account}
    # username already exists
    Element Should Be Visible  ${accExisted}  Account updated

UDACID04
    # update username to "", random iden, level 1
    ${selected cell}  Select Closest Selectable  ${table_accounts}  Username
    ${newIden}  Generate Random String  12  [NUMBERS]
    Click  ${formAccount}/ComboBox[@AutomationId="cbb_level"]/Button
    Click  ${formAccount}/ComboBox[@AutomationId="cbb_level"]/List/ListItem[1]
    Double Click  ${tb_username}
    Double Click  ${tb_username}
    Press Key  s'BACK'  ${tb_username}
    Press Key  t'${newIden}'  ${tb_iden}
    Click  ${btn_update_account}
    # username please enter
    Element Should Be Visible  ${username_pls}  Account updated

DELACID01
    ${selected cell}  Select Closest Selectable  ${table_accounts}  Username
    Click  ${btn_delete_account}
    # Account deleted
    Element Should Be Visible  ${accDeleted}  Account not deleted

DELACID02
    # don't select row
    Click  ${btn_delete_account}
    # please select an account
    Element Should Be Visible  ${formAccount}/Window/Text[@Name="Please select an account"]  Account deleted

SEACID01
    # input 123 into search textbox
    ${search}  Set Variable  123
    Press Key  t'${search}'  ${tb_search}
    Click  ${btn_search}
    # search account in table
    Search Account  ${search}

SEACID02
    # don't input anything
    Click  ${btn_search}
    ${search}  Set Variable  ${EMPTY}
    Search Account  ${search}

SEACID03
    # select a row and get its value then search that value
    ${selected cell}  Select Closest Selectable  ${table_accounts}  Username
    ${search}  Get Text From Textbox  ${selected cell}
    Press Key  t'${search}'  ${tb_search}
    Click  ${btn_search}
    # search account in table
    Search Account  ${search}
    