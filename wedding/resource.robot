#robot --argumentfile args.robot
*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               doMain specific language. They utilize keywords provided
...               by the imported SeleniumLibrary.
Library           FlaUILibrary

*** Variables ***
${name}           WeddingManagementApplication.exe
${path}           F:\\Github\\WeddingManagement\\WeddingManagementApplication\\WeddingManagementApplication\\bin\\Debug\\WeddingManagementApplication.exe
${PID}            0
${i}              -1
${selected_table_index}

*** Keywords ***
Attach Application
    ${pid}    Launch Application    ${path}
    Set Suite Variable    ${PID}    ${pid}
    Attach Application By PID    ${pid}

Shutdown Application
    Close Application    ${PID}

Log In
    [Arguments]    ${username}    ${password}
    Press Key    t'${username}'    /Window[@AutomationId='FormLogin']/Pane[1]/Edit[2]
    Press Key    t'${password}'    /Window[@AutomationId='FormLogin']/Pane[1]/Edit[1]
    Click    /Window[@AutomationId='FormLogin']/Pane[1]/Button

Select Cell With Attribute
    [Tags]    robot:private
    [Arguments]  ${table}  ${attribute}  ${value}
    [Return]  ${i}
    ${ip}  Evaluate  ${i} + 1
    Set Test Variable  ${i}  ${ip}
    ${row}  Set Variable  ${table}/Custom[@Name="Row ${i}"]
    ${cell}  Set Variable  ${row}/Edit[@Name="${attribute} Row ${i}, Not sorted."]
    # check if cell exists
    ${exists}  Run Keyword And Return Status  Element Should Exist  ${cell}
    ${cell value}  Get Text From Textbox  ${cell}
    Run Keyword If  '${cell value}' == '${value}'  Click  ${cell}
    ...  ELSE  Run Keywords  Press Key  s'DOWN'  AND  Select Cell With Attribute  ${table}  ${attribute}  ${value}

Select Cell With Attribute And Value
    [Arguments]  ${table}  ${attribute}  ${value}
    [Return]  ${i}
    # check if attribute exists
    ${column exists}  Run Keyword And Return Status  Element Should Exist  ${table}/Custom[@Name="Top Row"]/Header[@Name="${attribute}"]
    Element Should Exist  ${table}/Custom[@Name="Row 0"]/Edit[@Name="${attribute} Row 0, Not sorted."]
    ${selectable}  Run Keyword And Return Status  Element Should Be Visible  ${table}/Custom[@Name="Row 0"]/Edit[@Name="${attribute} Row 0, Not sorted."]
    Run Keyword If  ${selectable} == ${False}  Select Closest Selectable  ${table}  ${attribute}
    ...  ELSE  Click  ${table}/Custom[@Name="Row 0"]/Edit[@Name="${attribute} Row 0, Not sorted."]
    Select Cell With Attribute  ${table}  ${attribute}  ${value} 

Select Closest Selectable
    [Arguments]  ${table}  ${attribute}  ${num}=-1
    ${num}  Evaluate  ${num} + 1
    [Return]  ${table}/Custom[@Name="Row ${num}"]/Edit[@Name="${attribute} Row ${num}, Not sorted."]
    Set Test Variable  ${selected_table_index}  ${num}
    Element Should Exist  ${table}/Custom[@Name="Row ${num}"]/Edit[@Name="${attribute} Row ${num}, Not sorted."]
    ${selectable}  Run Keyword And Return Status  Element Should Be Visible  ${table}/Custom[@Name="Row ${num}"]/Edit[@Name="${attribute} Row ${num}, Not sorted."]
    Run Keyword If  ${selectable} == ${True}  Click  ${table}/Custom[@Name="Row ${num}"]/Edit[@Name="${attribute} Row ${num}, Not sorted."]
    ...  ELSE  Select Closest Selectable  ${table}  ${attribute}  ${num+1}

Select Cell At Row
    [Arguments]  ${table}  ${index}  ${attribute}
    Element Should Exist  ${table}/Custom[@Name="Row ${index}"]/Edit[@Name="${attribute} Row ${index}, Not sorted."]
    ${visible}  Run Keyword And Return Status  Element Should Be Visible  ${table}/Custom[@Name="Row ${index}"]/Edit[@Name="${attribute} Row ${index}, Not sorted."]
    Run Keyword If  ${visible} == ${True}  Click  ${table}/Custom[@Name="Row ${index}"]/Edit[@Name="${attribute} Row ${index}, Not sorted."]
    ...  ELSE  Select Closest Selectable  ${table}  ${attribute}
    Move To Target Row  ${table}  ${attribute}  ${selected_table_index}  ${index}
    
Move To Target Row
    [Arguments]  ${table}  ${attribute}  ${current}  ${target}
    ${current}  Convert To Integer  ${current}
    ${target}  Convert To Integer  ${target}
    ${diff}  Evaluate  ${target} - ${current}
    ${diff}  Convert To Integer  ${diff}
    # if diff is negative, move up
    Run Keyword If  ${diff} < 0  Press Key  s'UP'  ${diff}
    ...  ELSE IF  ${diff} > 0  Press Key  s'DOWN'  ${diff}
    ...  ELSE  No Operation
