#robot --argumentfile args.robot
*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               doMain specific language. They utilize keywords provided
...               by the imported SeleniumLibrary.
Library           SeleniumLibrary

*** Variables ***
${SERVER}               dineshvelhal.github.io/testautomation-playground/login.html
${BROWSER}              Firefox
${DELAY}                0
${VALID USERNAME}       admin
${VALID PASSWORD}       admin
${Main URL}             http://${SERVER}

*** Keywords ***
Open Browser To Main Page
    Open Browser    ${Main URL}    ${BROWSER}
    Set Selenium Speed    ${DELAY}
    Main Page Should Be Open
	

Main Page Should Be Open
    Title Should Be    Login

Go To Main Page
    Go To    ${Main URL}
    Main Page Should Be Open