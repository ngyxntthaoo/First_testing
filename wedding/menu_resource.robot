*** Settings ***
Resource      resource.robot

*** Variables ***

# dialogs
${menu_added}   ${formMenu}/Window[@Name="SUCCESS"]

# textboxes
${tb_search}    ${formMenu}/Edit[@AutomationId="tb_search_dishes"]
${tb_name}      ${formMenu}/Edit[@AutomationId="tb_dishes_name"]
${tb_price}     ${formMenu}/Edit[@AutomationId="tb_dishes_price"]
${tb_note}      ${formMenu}/Edit[@AutomationId="tb_dishes_note"]

# buttons
${btn_menu_search}    ${formMenu}/Button[@AutomationId="btn_search"]
${btn_menu_add}       ${formMenu}/Button[@AutomationId="btn_add_dishes"]
${btn_menu_update}    ${formMenu}/Button[@AutomationId="btn_update_dishes"]
${btn_menu_delete}    ${formMenu}/Button[@AutomationId="btn_delete_dishes"]

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

Add Menu
    [Arguments]  ${name}  ${price}  ${note}=${EMPTY}
    LOG  ${name} ${price} ${note}
    [Documentation]    A keyword for adding a menu
    ...                This keyword return True when the menu is added successfully
    ...                This keyword return False when the menu is not added successfully
    IF  '${name}' != '${EMPTY}'
        Press Key  t'${name}'  ${tb_name}
    END
    IF  '${price}' != '${EMPTY}'
        Press Key  t'${price}'  ${tb_price}
    END
    IF  '${note}' != '${EMPTY}'
        Press Key  t'${note}'  ${tb_note}
    END
    Click  ${btn_menu_add}
