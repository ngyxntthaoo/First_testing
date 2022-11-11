*** Settings ***
Documentation    A test suite containing tests for wedding of the app
...              Wedding Management
Library          String
Resource         resource.robot
Resource         wedding_resource.robot
Test Setup       Run Keywords  Attach Application  AND  Log In  123  123  AND  Open Wedding Window
Test Teardown    Shutdown Application

*** Test Cases ***
UTCID01
    Input Wedding  "Sảnh A1"  "Trưa"  Nguyễn Văn An  0904163258  500  10  Nguyễn Văn An  Lê Huyền Trân  100000000  2022  30  10  2022  2  11  500  500
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
    Set Test Variable  ${i}  -1
    Press Key  s'DOWN'
    Press Key  s'RIGHT'
    Select Cell With Attribute And Value  ${wedding table}  Shift  Trưa
    Set Test Variable  ${i}  -1
    Press Key  s'DOWN'
    Press Key  s'RIGHT'
    Select Cell With Attribute And Value  ${wedding table}  Representative  Nguyễn Văn An
    Set Test Variable  ${i}  -1
    Press Key  s'DOWN'
    Press Key  s'RIGHT'
    Select Cell With Attribute And Value  ${wedding table}  Phone number  0904163258
    Set Test Variable  ${i}  -1
    Press Key  s'DOWN'
    Press Key  s'RIGHT'
    Select Cell With Attribute And Value  ${wedding table}  Booking date  30/10/2022
    Set Test Variable  ${i}  -1
    Press Key  s'DOWN'
    Press Key  s'RIGHT'
    Select Cell With Attribute And Value  ${wedding table}  Wedding date  02/11/2022
    Set Test Variable  ${i}  -1
    Press Key  s'DOWN'
    Press Key  s'RIGHT'
    Select Cell With Attribute And Value  ${wedding table}  Groom name  Nguyễn Văn An
    Set Test Variable  ${i}  -1
    Press Key  s'DOWN'
    Press Key  s'RIGHT'
    Select Cell With Attribute And Value  ${wedding table}  Bride name  Lê Huyền Trân
    Set Test Variable  ${i}  -1
    Press Key  s'DOWN'
    Press Key  s'RIGHT'
    Select Cell With Attribute And Value  ${wedding table}  Amount of table  500
    Set Test Variable  ${i}  -1
    Press Key  s'DOWN'
    Press Key  s'RIGHT'
    Select Cell With Attribute And Value  ${wedding table}  Amount of contingency table  10
    Set Test Variable  ${i}  -1
    Press Key  s'DOWN'
    Press Key  s'RIGHT'
    Select Cell With Attribute And Value  ${wedding table}  Table price  510000000
    Set Test Variable  ${i}  -1
    Press Key  s'DOWN'
    Press Key  s'RIGHT'
    Select Cell With Attribute And Value  ${wedding table}  Deposit  100000000
    
    [Teardown]
    Click  ${btn_delete wedding}
    Shutdown Application

UTCID02
    Input Wedding  "Sảnh A1"  "Trưa"  nguyễn văn an  0904163258  500  10  nguyễn văn an  lê huyền trân  100000000  2022  30  10  2022  2  11  500  500
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
    Set Test Variable  ${i}  -1
    Press Key  s'DOWN'
    Press Key  s'RIGHT'
    Select Cell With Attribute And Value  ${wedding table}  Shift  Trưa
    Set Test Variable  ${i}  -1
    Press Key  s'DOWN'
    Press Key  s'RIGHT'
    Select Cell With Attribute And Value  ${wedding table}  Representative  nguyễn văn an
    Set Test Variable  ${i}  -1
    Press Key  s'DOWN'
    Press Key  s'RIGHT'
    Select Cell With Attribute And Value  ${wedding table}  Phone number  0904163258
    Set Test Variable  ${i}  -1
    Press Key  s'DOWN'
    Press Key  s'RIGHT'
    Select Cell With Attribute And Value  ${wedding table}  Booking date  30/10/2022
    Set Test Variable  ${i}  -1
    Press Key  s'DOWN'
    Press Key  s'RIGHT'
    Select Cell With Attribute And Value  ${wedding table}  Wedding date  02/11/2022
    Set Test Variable  ${i}  -1
    Press Key  s'DOWN'
    Press Key  s'RIGHT'
    Select Cell With Attribute And Value  ${wedding table}  Groom name  nguyễn văn an
    Set Test Variable  ${i}  -1
    Press Key  s'DOWN'
    Press Key  s'RIGHT'
    Select Cell With Attribute And Value  ${wedding table}  Bride name  lê huyền trân
    Set Test Variable  ${i}  -1
    Press Key  s'DOWN'
    Press Key  s'RIGHT'
    Select Cell With Attribute And Value  ${wedding table}  Amount of table  500
    Set Test Variable  ${i}  -1
    Press Key  s'DOWN'
    Press Key  s'RIGHT'
    Select Cell With Attribute And Value  ${wedding table}  Amount of contingency table  10
    Set Test Variable  ${i}  -1
    Press Key  s'DOWN'
    Press Key  s'RIGHT'
    Select Cell With Attribute And Value  ${wedding table}  Table price  510000000
    Set Test Variable  ${i}  -1
    Press Key  s'DOWN'
    Press Key  s'RIGHT'
    Select Cell With Attribute And Value  ${wedding table}  Deposit  100000000
    
    [Teardown]
    Click  ${btn_delete wedding}
    Shutdown Application

UTCID04
    # this time all names are upercase
    Input Wedding  "Sảnh A1"  "Trưa"  NGUYỄN VĂN AN  0904163258  500  10  NGUYỄN VĂN AN  LÊ HUYỀN TRÂN  100000000  2022  30  10  2022  2  11  500  500
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
    Set Test Variable  ${i}  -1
    Press Key  s'DOWN'
    Press Key  s'RIGHT'
    Select Cell With Attribute And Value  ${wedding table}  Shift  Trưa
    Set Test Variable  ${i}  -1
    Press Key  s'DOWN'
    Press Key  s'RIGHT'
    Select Cell With Attribute And Value  ${wedding table}  Representative  NGUYỄN VĂN AN
    Set Test Variable  ${i}  -1
    Press Key  s'DOWN'
    Press Key  s'RIGHT'
    Select Cell With Attribute And Value  ${wedding table}  Phone number  0904163258
    Set Test Variable  ${i}  -1
    Press Key  s'DOWN'
    Press Key  s'RIGHT'
    Select Cell With Attribute And Value  ${wedding table}  Booking date  30/10/2022
    Set Test Variable  ${i}  -1
    Press Key  s'DOWN'
    Press Key  s'RIGHT'
    Select Cell With Attribute And Value  ${wedding table}  Wedding date  02/11/2022
        
    Set Test Variable  ${i}  -1
    Press Key  s'DOWN'
    Press Key  s'RIGHT'
    Select Cell With Attribute And Value  ${wedding table}  Groom name  NGUYỄN VĂN AN
    Set Test Variable  ${i}  -1
    Press Key  s'DOWN'
    Press Key  s'RIGHT'
    Select Cell With Attribute And Value  ${wedding table}  Bride name  LÊ HUYỀN TRÂN
    Set Test Variable  ${i}  -1
    Press Key  s'DOWN'
    Press Key  s'RIGHT'
    Select Cell With Attribute And Value  ${wedding table}  Amount of table  500
    Set Test Variable  ${i}  -1
    Press Key  s'DOWN'
    Press Key  s'RIGHT'
    Select Cell With Attribute And Value  ${wedding table}  Amount of contingency table  10
    Set Test Variable  ${i}  -1
    Press Key  s'DOWN'
    Press Key  s'RIGHT'
    Select Cell With Attribute And Value  ${wedding table}  Table price  510000000
    Set Test Variable  ${i}  -1
    Press Key  s'DOWN'
    Press Key  s'RIGHT'
        
    Select Cell With Attribute And Value  ${wedding table}  Deposit  100000000
    
    Input Wedding  "Sảnh A1"  "Trưa"  NGUYỄN VĂN AN  0904163258  500  10  NGUYỄN VĂN AN  LÊ HUYỀN TRÂN  100000000  2022  30  10  2022  2  11  500  500
    Click  ${btn_add wedding}
    Element Should Not Exist  ${ wedding form}/Window[@Name="SUCCESS"]
    ENTER
    
    [Teardown]
    Click  ${btn_delete wedding}
    Shutdown Application    

UTCID05
    Input Wedding  "Sảnh A1"  "Trưa"  NGUYỄN VĂN AN  abc  abc  abc  NGUYỄN VĂN AN  LÊ HUYỀN TRÂN  abc  2022  30  10  2022  2  11  abc  abc
    Click  ${btn_add wedding}
    Element Should Be Visible  ${wedding form}/Window[@Name="NhanTiec"]

UTCID06
    Input Wedding  "Sảnh A1"  "Trưa"  123  0904163258  500  10  123  123  100000000  2022  30  10  2022  2  11  500  500
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
    Set Test Variable  ${i}  -1
    Press Key  s'DOWN'
    Press Key  s'RIGHT'
    Select Cell With Attribute And Value  ${wedding table}  Shift  Trưa
    Set Test Variable  ${i}  -1
    Press Key  s'DOWN'
    Press Key  s'RIGHT'
    Select Cell With Attribute And Value  ${wedding table}  Representative  123
    Set Test Variable  ${i}  -1
    Press Key  s'DOWN'
    Press Key  s'RIGHT'
    Select Cell With Attribute And Value  ${wedding table}  Phone number  0904163258
    Set Test Variable  ${i}  -1
    Press Key  s'DOWN'
    Press Key  s'RIGHT'
    Select Cell With Attribute And Value  ${wedding table}  Booking date  30/10/2022
    Set Test Variable  ${i}  -1
    Press Key  s'DOWN'
    Press Key  s'RIGHT'
    Select Cell With Attribute And Value  ${wedding table}  Wedding date  02/11/2022
        
    Set Test Variable  ${i}  -1
    Press Key  s'DOWN'
    Press Key  s'RIGHT'
    Select Cell With Attribute And Value  ${wedding table}  Groom name  123
    Set Test Variable  ${i}  -1
    Press Key  s'DOWN'
    Press Key  s'RIGHT'
    Select Cell With Attribute And Value  ${wedding table}  Bride name  123
    Set Test Variable  ${i}  -1
    Press Key  s'DOWN'
    Press Key  s'RIGHT'
    Select Cell With Attribute And Value  ${wedding table}  Amount of table  500
    Set Test Variable  ${i}  -1
    Press Key  s'DOWN'
    Press Key  s'RIGHT'
    Select Cell With Attribute And Value  ${wedding table}  Amount of contingency table  10
    Set Test Variable  ${i}  -1
    Press Key  s'DOWN'
    Press Key  s'RIGHT'
    Select Cell With Attribute And Value  ${wedding table}  Table price  510000000
    Set Test Variable  ${i}  -1
    Press Key  s'DOWN'
    Press Key  s'RIGHT'
        
    Select Cell With Attribute And Value  ${wedding table}  Deposit  100000000
    [Teardown]
    Click  ${btn_delete wedding}
    Shutdown Application

UTCID07
    Input Wedding  "Sảnh A1"  "Trưa"  123  123a  123a  123a  123  123  123a  2022  30  10  2022  2  11  123a  123a
    Click  ${btn_add wedding}
    Element Should Be Visible  ${wedding form}/Window[@Name="NhanTiec"]

UTCID08
    Input Wedding  "Sảnh A1"  "Trưa"  \#!@  123a  123a  \#!@  \#!@  \#!@  \#!@  2022  30  10  2022  2  11  \#!@  \#!@
    Click  ${btn_add wedding}
    Element Should Be Visible  ${wedding form}/Window[@Name="NhanTiec"]

UTCID09
    Input Wedding  "Sảnh A1"  "Trưa"  Nguyễn Văn An  123a  123a  123a  Nguyễn Văn An  Lê Huyền Trân  123a  2022  30  10  2022  2  11  123a  123a
    Click  ${btn_add wedding}
    Element Should Be Visible  ${wedding form}/Window[@Name="NhanTiec"]

UTCID10
    Input Wedding  "Sảnh A1"  "Trưa"  nguyễn văn an  0904163258  500  10  nguyễn văn an  lê kuyền trân  100000000  2022  30  10  2022  2  11  \#!@  \#!@
    Click  ${btn_add wedding}
    ENTER
    Click  ${header row zero}
    Click  ${btn_add_menu}
    Element Should Exist  ${wedding form}/Window[@Name="LACK"]
    [Teardown]
    ENTER
    Click  ${btn_delete wedding}
    Shutdown Application
