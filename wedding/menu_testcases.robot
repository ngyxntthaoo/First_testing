*** Settings ***
Documentation    A test suite containing tests for menu of the app
...              Wedding Management
Library          String
Resource         resource.robot
Resource         menu_resource.robot
Suite Setup      Run Keywords  Attach Application  AND  Log In  123  123
Test Setup       Open Menu Window
Test Teardown    Close Menu Window
Suite Teardown   Shutdown Application

*** Test Cases ***
Menu search v01
    [Documentation]    Search for a menu item
    [Tags]    menu  search  v01
    Search  Mì

Menu search v02
    [Documentation]    Search for a menu item
    [Tags]    menu  search  v02
    Search  20000

Menu search v03
    [Documentation]    Search for a menu item
    [Tags]    menu  search  v03
    Search  mi

Menu search v04
    [Documentation]    Search for a menu item
    [Tags]    menu  search  v04
    Search  20.000

Menu add v01
    [Documentation]    Add a menu item with valid values
    [Tags]    menu  add  v01
    Add Menu    canh cua  30000  a
    Element Should Exist  ${menu_added}
    Press Key  s'ENTER'
    Search  canh cua

Menu add v02
    [Documentation]    Add a menu item with invalid name
    [Tags]    menu  add  v02
    Add Menu  1234  30000
    Element Should Not Exist  ${menu_added}  invalid dish added

Menu add v03
    [Documentation]    Add a menu item with invalid name
    [Tags]    menu  add  v03
    Add Menu  \#bánh bò  332000
    Element Should Not Exist  ${menu_added}  invalid dish added

Menu update v01
    [Documentation]    Update a menu item with valid values
    [Tags]    menu  update  v01
    ${cell}  Select Closest Selectable  ${table_menu}  Dishes name
    ${value}  Get Text From Textbox  ${cell}
    Click  ${cell}
    ${random}  Generate Random String  20
    ${rannum}  Generate Random String  5-9  [NUMBERS]
    Press Key  t'${random}'  ${tb_name}
    Press Key  t'${rannum}'  ${tb_price}
    Press Key  t'${random}${rannum}'  ${tb_note}
    Click  ${btn_menu_update}
    ENTER
    Search  ${random}


*** Keywords ***
Search
    [Arguments]    ${search str}
    Press Key  t'${search str}'  ${tb_search}
    Click  ${btn_menu_search}
    Search Table  ${table_menu}  ${search str}  ${True}  DishesName  DishesPrice
