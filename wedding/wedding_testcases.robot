*** Settings ***
Documentation    A test suite containing tests for wedding of the app
...              Wedding Management
Library          String
Resource         resource.robot
Resource         wedding_resource.robot
Suite Setup      Run Keywords  Attach Application  AND  Log In  123  123
Test Setup       Open Wedding Window
Test Teardown    Close Wedding Window
Suite Teardown   Shutdown Application

*** Test Cases ***
UTCID01
    Input Wedding  "Sảnh A1"  "Trưa"  Nguyễn Văn An  0904163258  500  10  Nguyễn Văn An  Lê Huyền Trân  100000000  2022  10  30  2022  11  2  500  500
    Click  ${btn_add wedding}
    Element Should Exist  ${wedding form}/Window[@Name="SUCCESS"]
    ENTER
    Click  ${header row zero}
    Click  ${btn_add_menu}
    Element Should Exist  ${wedding form}/Window[@Name="SUCCESS"]
    ENTER
    Click  ${btn_add_service}
    Element Should Exist  ${wedding form}/Window[@Name="SUCCESS"]
    ENTER
    Select Cell With Attribute And Value  ${wedding table}  Lobby name  Sảnh A1
    # Set Test Variable  ${i}  0
    # Press Key  s'RIGHT'
    # press Key  s'UP'
    # Select Cell With Attribute And Value  ${wedding table}  Shift  Tối
    # Set Test Variable  ${i}  0
    # Press Key  s'RIGHT'
    # press Key  s'UP'
    # Select Cell With Attribute And Value  ${wedding table}  Representative  Nguyễn Văn An
    # Set Test Variable  ${i}  0
    # Press Key  s'RIGHT'
    # press Key  s'UP'
    # Select Cell With Attribute And Value  ${wedding table}  Phone number  0904163258
    # Set Test Variable  ${i}  0
    # Press Key  s'RIGHT'
    # press Key  s'UP'
    # Select Cell With Attribute And Value  ${wedding table}  Booking date  30/10/2022
    # Set Test Variable  ${i}  0
    # Press Key  s'RIGHT'
    # press Key  s'UP'
    # Select Cell With Attribute And Value  ${wedding table}  Wedding date  02/11/2022
    # Set Test Variable  ${i}  0
    # Press Key  s'RIGHT'
    # press Key  s'UP'
    # Select Cell With Attribute And Value  ${wedding table}  Groon name  Nguyễn Văn An
    # Set Test Variable  ${i}  0
    # Press Key  s'RIGHT'
    # press Key  s'UP'
    # Select Cell With Attribute And Value  ${wedding table}  Bride name  Lê Huyền Trân
    # Set Test Variable  ${i}  0
    # Press Key  s'RIGHT'
    # press Key  s'UP'
    # Select Cell With Attribute And Value  ${wedding table}  Amount of table  10
    # Set Test Variable  ${i}  0
    # Press Key  s'RIGHT'
    # press Key  s'UP'
    # Select Cell With Attribute And Value  ${wedding table}  Amount of contigency table  10
    # Set Test Variable  ${i}  0
    # Press Key  s'RIGHT'
    # press Key  s'UP'
    # Select Cell With Attribute And Value  ${wedding table}  Table Price  500
    # Set Test Variable  ${i}  0
    # Press Key  s'RIGHT'
    # press Key  s'UP'
    # Select Cell With Attribute And Value  ${wedding table}  Deposit  500