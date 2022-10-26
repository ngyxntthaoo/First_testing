*** Settings ***
Resource      resource.robot

*** Variables ***

# textboxes
${tb_search}    ${formMenu}/Edit[@AutomationId="tb_search_dishes"]

# buttons
${btn_menu_search}    ${formMenu}/Button[@AutomationId="btn_search"]

# tables
${table_menu}   ${formMenu}/Table[@AutomationId="data_gv_dishes"]

*** Keywords ***

Search Menu
    [Arguments]  ${string to search}
    [Documentation]    A keyword for searching a menu
    ...                This keyword return True when all the dishes
    ...                in the table contain the string to search
    ...                in their dishes name or price
    ...                If the table contains no dishes, it will also return True
    ...                This keyword return False when there is at least
    ...                one dish that does not contain the string to search
    Press Key  t'${string to search}'  ${tb_search}
    Press Key  s'ENTER'
    ${continue}  Set Variable  ${True}
    ${wrong}  Set Variable  ${False}
    ${i}  Set Variable  0
    Select Closest Selectable  ${table_menu}  Dishes name
    WHILE  ${continue}
        ${condition 1}  Element Should Exist  ${table_menu}/Custom[@Name="Row ${i}"]
        IF  ${condition 1}
            ${name}  Get Text From Textbox  ${table_menu}/Custom[@Name="Row ${i}"]/Edit[@Name="Dishes name Row ${i}, Not sorted."]
            ${price}  Get Text From Textbox  ${table_menu}/Custom[@Name="Row ${i}"]/Edit[@Name="Dishes Price Row ${i}, Not sorted."]
            ${condition 2}  Run Keyword And Return Status  Should Contain  ${name}  ${string to search}
            ${condition 3}  Run Keyword And Return Status  Should Contain  ${price}  ${string to search}
            IF  ${condition 2} or ${condition 3}
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
