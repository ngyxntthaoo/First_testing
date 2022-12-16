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

# windows
${formLogin}       /Window[@AutomationId='FormLogin']
${formHome}        /Window[@AutomationId='FormHome']
${formMenu}        ${formHome}/Window[@AutomationId='FormDishes']
${formServices}    ${formHome}/Window[@AutomationId='FormServices']
${formWedding}     ${formHome}/Window[@AutomationId='NhanTiec']

${dialogCommingSoon}       ${formHome}/Window[@Name='CLOSE']


# panes
${searchDropDown1}  ${formHome}/Pane[@AutomationId='searchDropDown1']
${lobbyDropDown1}   ${formHome}/Pane[@AutomationId='lobbyDropDown1']
${reportDropDown1}  ${formHome}/Pane[@AutomationId='reportDropDown1']

# buttons
${btnSearch}    ${formHome}/Pane[@AutomationId="panel1"]/Button[@AutomationId="btnSearch"]
${btnLobby}     ${formHome}/Pane[@AutomationId="panel1"]/Button[@AutomationId="btnLobby"]
${btnReport}    ${formHome}/Pane[@AutomationId="panel1"]/Button[@AutomationId="btnReport"]
${btnMenu}      ${formHome}/Pane[@AutomationId="panel1"]/Button[@AutomationId="btnMenu"]
${btnService}   ${formHome}/Pane[@AutomationId="panel1"]/Button[@AutomationId="btnService"]
${btnWedding}   ${formHome}/Pane[@AutomationId="panel1"]/Button[@AutomationId="btnWedding"]
${btnSettings}  ${formHome}/Pane[@AutomationId="panel1"]/Button[@AutomationId="btnSettings"]
${btnLogout}    ${formHome}/Pane[@AutomationId="panel1"]/Button[@AutomationId="btnLogout"]

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
    [Documentation]  Selects a cell in a table with a given attribute and value.
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
    Run Keyword If  ${diff} < 0  Press Key  s'UP'
    ...  ELSE IF  ${diff} > 0  Press Key  s'DOWN'
    ...  ELSE  No Operation

Open Search Dropdown
    [Documentation]    A keyword for opening the search dropdown
    [Tags]    Search
    Click  ${btnSearch}
    ${Result}  Run Keyword And Return Status  Element Should Be Visible  ${searchDropDown1}
    Run Keyword If  ${Result} == ${False}  Open Search Dropdown

Open Lobby Dropdown
    [Documentation]    A keyword for opening the lobby dropdown
    [Tags]    Lobby
    Click  ${btnLobby}
    ${Result}  Run Keyword And Return Status  Element Should Be Visible  ${lobbyDropDown1}
    Run Keyword If  ${Result} == ${False}  Open Lobby Dropdown

Open Report Dropdown
    [Documentation]    A keyword for opening the report dropdown
    [Tags]    Report
    Click  ${btnReport}
    ${Result}  Run Keyword And Return Status  Element Should Be Visible  ${reportDropDown1}
    Run Keyword If  ${Result} == ${False}  Open Report Dropdown

Open Menu Window
    [Documentation]    A keyword for opening the menu page
    [Tags]    Menu
    Click  ${btnMenu}
    Element Should Be Visible  ${formMenu}

Close Menu Window
    [Documentation]    A keyword for closing the menu page
    [Tags]    Menu
    Click  ${formMenu}/Text[@Name="X"]
    Element Should Not Exist  ${formMenu}

Open Settings Window
    [Documentation]    A keyword for opening the settings page
    [Tags]    Settings
    Click  ${btnSettings}
    Element Should Exist  ${dialogCommingSoon}

Open Wedding Window
    [Documentation]    A keyword for opening the wedding page
    [Tags]    Wedding
    Click  ${btnWedding}
    Element Should Be Visible  ${formWedding}

Close Wedding Window
    [Documentation]    A keyword for closing the wedding page
    [Tags]    Wedding
    Click  ${formWedding}/Text[@Name="X"]
    Element Should Not Exist  ${formWedding}

Open Service Window
    [Documentation]    A keyword for opening the service page
    [Tags]    Service
    Click  ${btnService}
    Element Should Be Visible  ${formServices}

Close Service Window
    [Documentation]    A keyword for closing the service page
    [Tags]    Service
    Click  ${formServices}/Text[@Name="X"]
    Element Should Not Exist  ${formServices}

Log Out
    [Documentation]    A keyword for logging out of the application
    [Tags]    Logout
    Click  ${btnLogout}
    Element Should Be Visible  ${formLogin}

ENTER
    [Documentation]    A keyword for pressing the ENTER key
    [Tags]    Keyboard
    Press Key  s'ENTER'

Search Table
    [Arguments]  ${table}  ${string to search}  ${ignore_case}  ${equal}=${False}  @{attributes}
    [Documentation]    A keyword for searching a table
    ...                This keyword return True when all rows
    ...                in the table contain the string to search
    ...                in their specified attributes (columns)
    ...                If the table contains no rows, it will also return True
    ...                This keyword return False when there is at least
    ...                one row that does not contain the string to search.
    ${continue}  Set Variable  ${True}
    ${wrong}  Set Variable  ${False}
    Set Test Variable  ${i}  0
    Log  this are ${i}
    Log  ${attributes}
    Run Keyword And Return Status  Select Closest Selectable  ${table}  ${attributes[0]}
    WHILE  ${continue}
        ${condition 1}  Run Keyword And Return Status  Element Should Exist  ${table}/Custom[@Name="Row ${i}"]
        IF  ${condition 1}
            ${condition 2}  Set Variable  ${False}
            FOR  ${attribute}  IN  @{attributes}
                ${value}    Get Text From Textbox   ${table}/Custom[@Name="Row ${i}"]/Edit[@Name="${attribute} Row ${i}, Not sorted."]
                IF  (${Equal} == ${False})  
                    ${condition 2}  Run Keyword And Return Status  Should Contain  ${value}  ${string to search}  ignore_case=${ignore_case}
                ELSE
                    ${condition 2}  Run Keyword And Return Status  Should Be Equal As Integers  ${value}  ${string to search}
                END
                IF  ${condition 2}
                    BREAK
                END
            END
            IF  ${condition 2} == ${False}
                ${continue}  Set Variable  ${False}
                ${wrong}  Set Variable  ${True}
                BREAK
            END
        ELSE
            ${continue}  Set Variable  ${False}
        END
        Press Key  s'DOWN'
        ${i}  Evaluate  ${i} + 1
        Set Test Variable  ${i}  ${i}
    END
    Should Not Be True  ${wrong}  Found row with wrong data
    