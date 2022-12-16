*** Settings ***
Resource      resource.robot

*** Variables ***
${formSearchWedding}  ${formHome}/Window[@AutomationId='searchWedding']
${formBill}  ${formSearchWedding}/Window[@AutomationId='FormBill']

${buttonSave}  ${formBill}/Button[@AutomationId='btn_save']
${buttonExit}  ${formBill}/Text[@Name='X']

${buttonExitAll}  ${formSearchWedding}/Text[@Name='X']

${tb_penalty}  ${formBill}/Edit[@AutomationId='tb_penalty']
${tb_moneyLeft}  ${formBill}/Group/Edit[@AutomationId='tb_moneyLeft']

${ruleYes}  ${formBill}/Group[@AutomationId='groupBox5']/RadioButton[@Name='Yes']
${ruleNo}  ${formBill}/Group[@AutomationId='groupBox5']/RadioButton[@Name='No']

${payYes}  ${formBill}/Group[@AutomationId='groupBox6']/RadioButton[@Name='Yes']
${payNo}  ${formBill}/Group[@AutomationId='groupBox6']/RadioButton[@Name='No']

${btnBill}  ${formHome}/Pane[@AutomationId="searchDropDown1"]/Pane[@AutomationId="flowLayoutPanel1"]/Button[@AutomationId="bill"]

${tableWedding}  ${formSearchWedding}/Table[@AutomationId='dataWedding']
${tableBill}  ${formSearchWedding}/Table[@AutomationId='dataBill']

${saved}  ${formBill}/Window/Text[@Name="Saved!"]
${invalid}  ${formBill}/Window/Text[@Name="The penalty rate is invalid!"]
${invalidNull}  ${formBill}/Window/Text[@Name="Please enter penalty"]

*** Keywords ***
Open Wedding And Bill Form
    [Documentation]    A keyword for opening a wedding-bill form
    [Tags]    Wedding And Bill
    ${Result}  Run Keyword And Return Status  Element Should Be Visible  ${btnBill}  ${False}
    Run Keyword If  ${Result} == ${False}  Open Search Dropdown
    Click  ${btnBill}
    Wait Until Element Is Visible  ${formSearchWedding}

Open Bill Form
    [Documentation]    A keyword for opening a bill form
    [Tags]    Bill
    Select Closest Selectable  ${tableBill}  Representative
    Move Right Until MoneyLeft Is Visible
    Run Keyword And Ignore Error  Search Table  ${tableBill}  0  ${True}  ${True}  MoneyLeft
    Select Cell At Row  ${tableWedding}  ${i}  LobbyName
    Double Click  ${tableWedding}/Custom[@Name='Row ${i}']/Edit[@Name='LobbyName Row ${i}, Not sorted.']
    ENTER
    ${current_window}  Set Global Variable  ${formBill}

Move Right Until MoneyLeft Is Visible
    [Documentation]    A keyword for moving right until the money left column is visible
    [Tags]    Bill
    Press Key  s'RIGHT'
    ${Result}  Run Keyword And Return Status  Element Should Be Visible  ${tableBill}/Custom[@Name='Top Row']/Header[@Name='MoneyLeft']
    Run Keyword If  ${Result} == ${False}  Move Right Until MoneyLeft Is Visible
