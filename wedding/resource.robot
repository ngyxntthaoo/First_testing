#robot --argumentfile args.robot
*** Settings ***
Documentation     A resource file with reusable keywords and variables.
...
...               The system specific keywords created here form our own
...               doMain specific language. They utilize keywords provided
...               by the imported SeleniumLibrary.
Library           FlaUILibrary

*** Variables ***
${name}            WeddingManagementApplication.exe
*** Keywords ***

# This is a keyword that can be used to start the application under test.
# It is a good idea to use a keyword for this, because it can be used
# in multiple test cases.
Attach Application
    Attach Application By Name    ${name}

