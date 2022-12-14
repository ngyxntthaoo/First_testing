*** Settings ***
Documentation     A test suite containing tests for app wedding management
Resource          resource.robot
Resource          bill_resource.robot
Suite Setup       Run Keywords  Attach Application  AND  Log In  123  123
Test Setup        Run Keywords  Open Wedding And Bill Form  AND  Open Bill Form
Test Teardown     Run Keyword And Ignore Error  Run Keywords  ENTER  AND  Click  ${buttonExit}  AND  Click  ${buttonExitAll}
Suite Teardown    Shutdown Application

*** Test Cases ***
BIID01
    Press Key  t'0'  ${tb_penalty}
    Select Radiobutton  ${ruleNo}
    Select Radiobutton  ${payNo}
    ${money}  Get Text From Textbox  ${tb_moneyLeft}
    Sleep  2s  UI may not update immediately
    Should Not Be Equal As Integers  ${money}  0
    Click  ${buttonSave}
    Element Should Be Visible  ${saved}

BIID02
    Press Key  t'0'  ${tb_penalty}
    Select Radiobutton  ${ruleYes}
    Select Radiobutton  ${payYes}
    ${money}  Get Text From Textbox  ${tb_moneyLeft}
    # wait 3 seconds
    Sleep  2s  UI may not update immediately
    Should Be Equal As Integers  ${money}  0
    Click  ${buttonSave}
    Element Should Be Visible  ${saved}

BIID03
    Press Key  t'-99999'  ${tb_penalty}
    Select Radiobutton  ${ruleYes}
    Select Radiobutton  ${payYes}
    ${money}  Get Text From Textbox  ${tb_moneyLeft}
    Sleep  2s  UI may not update immediately
    Should Not Be Equal As Integers  ${money}  0
    Click  ${buttonSave}
    Element Should Be Visible  ${invalid}

BIID04    
    Press Key  t'-99999'  ${tb_penalty}
    Select Radiobutton  ${ruleYes}
    Select Radiobutton  ${payNo}
    ${money}  Get Text From Textbox  ${tb_moneyLeft}    
    Sleep  2s  UI may not update immediately
    Should Not Be Equal As Integers  ${money}  0
    Click  ${buttonSave}
    Element Should Be Visible  ${invalid}

BIID05
    Press Key  t'1'  ${tb_penalty}
    Select Radiobutton  ${ruleYes}
    Select Radiobutton  ${payYes}
    ${money}  Get Text From Textbox  ${tb_moneyLeft}
    Sleep  2s  UI may not update immediately
    Should Be Equal As Integers  ${money}  0
    Click  ${buttonSave}
    Element Should Be Visible  ${saved}

BIID06
    Press Key  t'1'  ${tb_penalty}
    Select Radiobutton  ${ruleNo}
    Select Radiobutton  ${payYes}
    ${money}  Get Text From Textbox  ${tb_moneyLeft}
    Should Be Equal As Integers  ${money}  0
    Sleep  2s  UI may not update immediately
    Click  ${buttonSave}
    Element Should Be Visible  ${saved}

BIID07
    Press Key  s'BACK'  ${tb_penalty}
    Select Radiobutton  ${ruleYes}
    Select Radiobutton  ${payYes}
    ${money}  Get Text From Textbox  ${tb_moneyLeft}
    Sleep  2s  UI may not update immediately
    Should Be Equal As Integers  ${money}  0
    Click  ${buttonSave}
    Element Should Be Visible  ${invalidNull}

BIID08    
    Press Key  s'BACK'  ${tb_penalty}
    Select Radiobutton  ${ruleYes}
    Select Radiobutton  ${payNo}
    ${money}  Get Text From Textbox  ${tb_moneyLeft}
    Sleep  2s  UI may not update immediately
    Should Not Be Equal As Integers  ${money}  0
    Click  ${buttonSave}
    Element Should Be Visible  ${saved}