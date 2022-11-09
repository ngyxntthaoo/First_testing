*** Settings ***
Resource  resource.robot

*** Variables ***
${wedding form}  ${formHome}/Window[@AutomationId="NhanTiec"]
${wedding group}  ${wedding form}/Group[@AutomationId="wedding"]

${btn_add wedding}  ${wedding form}/Button[@AutomationId="btn_add_wedding"]
${btn_update wedding}  ${wedding form}/Button[@AutomationId="btn_update_wedding"]
${btn_delete wedding}  ${wedding form}/Button[@AutomationId="btn_delete_wedding"]

${wedding table}  ${wedding form}/Table[@AutomationId="dataWedding"]
${header row zero}  ${wedding table}/Custom[@Name="Row 0"]/Header[@Name="Row 0"]

${combobox lobby}  ${wedding group}/ComboBox[@AutomationId="cbb_lobby"]
${button lobby}  ${combobox lobby}/Button[@Name="Open"]
${Lobby A1}  ${combobox lobby}/List[@Name="Lobby:"]/ListItem[@Name="Sảnh A1"]

${combobox shift}  ${wedding group}/ComboBox[@AutomationId="cbb_shift"]
${button shift}  ${combobox shift}/Button[@Name="Open"]
${mid day}  ${combobox shift}/List[@Name="Shift:"]/ListItem[@Name="Trưa"]
${afternoon}  ${combobox shift}/List[@Name="Shift:"]/ListItem[@Name="Tối"]

${tb_representative}  ${wedding group}/Edit[@AutomationId="tb_representative"]
${tb_phone}  ${wedding group}/Edit[@AutomationId="tb_phone"]
${tb_table}  ${wedding group}/Edit[@AutomationId="tb_table"]
${tb_contingency}  ${wedding group}/Edit[@AutomationId="tb_contigency"]
${tb_broom name}  ${wedding group}/Edit[@AutomationId="tb_groom"]
${tb_bridge name}  ${wedding group}/Edit[@AutomationId="tb_bride"]
${tb_deposit}  ${wedding group}/Edit[@AutomationId="tb_deposit"]

${group box date}  ${wedding form}/Group[@AutomationId="groupBox1"]
${booking date}  ${group box date}/ComboBox[@AutomationId="date_booking"]
${wedding date}  ${group box date}/ComboBox[@AutomationId="date_wedding"]

${group box menu}  ${wedding form}/Group[@AutomationId="groupBox_menu"]
${tb_dishes amount}  ${group box menu}/Edit[@AutomationId="tb_dishes_price"]
${btn_add_menu}  ${group box menu}/Button[@AutomationId="btn_add_menu"]

${group box service}  ${wedding form}/Group[@AutomationId="groupBox2"]
${tb_service amount}  ${group box service}/Edit[@AutomationId="tb_service_price"]
${btn_add_service}  ${group box service}/Button[@AutomationId="btn_add_service"]


*** Keywords ***
Input Date  
    [Arguments]  ${datepicker}  ${year}=0  ${month}=0  ${day}=0
    Click  ${datepicker}
    # if year is not 0, press key
    IF  ${year} != 0
        Press Key  t'${year}'
    END
    Press Key  s'LEFT'
    # if month is not 0, press key
    IF  ${month} != 0
        Press Key  t'${month}'
    END
    Press Key  s'LEFT'
    # if day is not 0, press key
    IF  ${day} != 0
        Press Key  t'${day}'
    END

Input Wedding
    [Arguments]  ${lobby}  ${shift}  ${representative}  ${phone}  ${table}  ${contingency}  ${groom}  ${bride}  ${deposit}  ${booking year}  ${booking month}  ${booking day}  ${wedding year}  ${wedding month}  ${wedding day}  ${dishes amount}  ${service amount}
    # input all arguments into textboxes
    Click  ${button lobby}
    # if lobby is "Lobby A1", click on it
    IF  ${lobby} == "Sảnh A1"
        Click  ${Lobby A1}
    END
    Click  ${button shift}
    # if shift is "Trưa", click on it
    IF  ${shift} == "Trưa"
        Click  ${mid day}
    # if shift is "Tối", click on it
    ELSE IF  ${shift} == "Tối"
        Click  ${afternoon}
    END
    # Press key
    Press Key  t'${representative}'  ${tb_representative}
    Press Key  t'${phone}'  ${tb_phone}
    Press Key  t'${table}'  ${tb_table}
    Press Key  t'${contingency}'  ${tb_contingency}
    Press Key  t'${groom}'  ${tb_broom name}
    Press Key  t'${bride}'  ${tb_bridge name}
    Press Key  t'${deposit}'  ${tb_deposit}
    # input date
    Input Date  ${booking date}  ${booking year}  ${booking month}  ${booking day}
    Input Date  ${wedding date}  ${wedding year}  ${wedding month}  ${wedding day}
    # input amount
    Press Key  t'${dishes amount}'  ${tb_dishes amount}
    Press Key  t'${service amount}'  ${tb_service amount}  

