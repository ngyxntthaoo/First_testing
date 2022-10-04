#robot --argumentfile args.robot
*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               doMain specific language. They utilize keywords provided
...               by the imported SeleniumLibrary.
Library           SeleniumLibrary

*** Variables ***
${SERVER}         random.org
${BROWSER}        Firefox
${DELAY}          0
${DEFAULT MIN}      0
${DEFAULT Max}      100
${Main URL}       http://${SERVER}/

*** Keywords ***
Open Browser To Main Page
    Open Browser    ${Main URL}    ${BROWSER}
    #Maximize Browser Window
    Set Selenium Speed    ${DELAY}
    Main Page Should Be Open
	

Main Page Should Be Open
    Title Should Be    RANDOM.ORG - True Random Number Service

Go To Main Page
    Go To    ${Main URL}
    Main Page Should Be Open