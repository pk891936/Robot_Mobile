*** Settings ***
Library  SeleniumLibrary
Library    ../../Automation/Resources/pyLibs/pythonKeywords.py

*** Test Cases ***
Verify Test in Chrome
    ${path}=    Get Driver Path    Chrome
    Open Browser    https://testux.securewebserv.com/signin    browser=Chrome    executable_path=${path}
    Maximize Browser Window
    Sleep   2
    ${title}=    Get Title
    Log To Console    Web Page Title: ${title}
    Close Browser
 
Verify Test in FF
    Launch Firefox Browser
    Go To    https://testux.securewebserv.com/signin
#    Open Browser    https://testux.securewebserv.com/signin    browser=firefox
#        executable_path=${path}    options=set_preference("ff_profile_dir","C://Users//ckumar2//AppData//Local//Mozilla Firefox//firefox.exe")
    Maximize Browser Window
    Sleep   2
    ${title}=    Get Title
    Log To Console    Web Page Title: ${title}
    Close Browser

Verify Test in Edge
    ${path}=    Get Driver Path    edge
    Open Browser    https://testux.securewebserv.com/signin    browser=edge    executable_path=${path}
    Maximize Browser Window
    Sleep   2
    ${title}=    Get Title
    Log To Console    Web Page Title: ${title}
     Close Browser
