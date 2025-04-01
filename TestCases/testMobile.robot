*** Settings ***
Documentation  Test Mobile App
Library  AppiumLibrary
Library    Process
Suite Teardown    Close All Applications
#Test Tags  webdriver
#Suite Setup  Open Test Application

*** Variables ***
${udid}    38221FDJH002NT
${ANDROID_AUTOMATION_NAME}    UIAutomator2
${SMA_APP}                C:/Users/ckumar2/PycharmProjects/RobotAPI/Automation/APKs/app-debug.apk
${DCS_APP}                C:/Users/ckumar2/PycharmProjects/RobotAPI/Automation/APKs/DCSDemoApp-BETA-debug.apk
${package_SMA}    com.allegion.sdkdemo
${package_DCS}    com.allegionengage.dcsdemo
${ANDROID_PLATFORM_NAME}      Android
#${ANDROID_PLATFORM_VERSION}   %{ANDROID_PLATFORM_VERSION=14}
${APPIUM SERVER URL}  http://127.0.0.1:4723/wd/hub
${WAIT_TIME_OUT}  20

*** Test Cases ***
Test to Launch and Switch mobile apps
    [Documentation]    Test to Launch and Switch SMA and Engage mobile apps
    ${smaApplication}=    Open Application  ${APPIUM SERVER URL}    automationName=${ANDROID_AUTOMATION_NAME}    platformName=${ANDROID_PLATFORM_NAME}    appPackage=${package_sma}  appActivity=${package_sma}.MainActivity  appWaitActivity=*    alias=QSA
    Sleep    5
    ${engageApplication}=    Open Application  ${APPIUM SERVER URL}    automationName=${ANDROID_AUTOMATION_NAME}    platformName=${ANDROID_PLATFORM_NAME}  appPackage=${package_DCS}  appActivity=${package_DCS}.MainActivity  appWaitActivity=*    alias=Engage
    Sleep    5
#    Switch Application    ${smaApplication}
    Start Activity    ${package_SMA}    ${package_SMA}.MainActivity
    Sleep   5
    Verify user should be on home page
    Sleep   10
    Start Activity    ${package_DCS}    ${package_DCS}.MainActivity
    Sleep   5

*** Keywords ***
Install Application
    [Arguments]    ${apk_path}
    Run Process    adb    start-server
    ${return_code}    Run Process    adb    install    ${apk_path}
    Run Process    adb    kill-server
#    ${return_code}    Convert To Integer    ${return_code}
#    Should Be Equal As Strings    ${return_code}    Success

Launch SMA Application
    Log To Console    Launching SMA Application
    ${smaApplication}=    Open Application  ${APPIUM SERVER URL}    udid=${udid}  automationName=${ANDROID_AUTOMATION_NAME}    platformName=${ANDROID_PLATFORM_NAME}    appPackage=${package_sma}  appActivity=${package_sma}.MainActivity  appWaitActivity=*    alias=QSA
    Sleep    5
#      app=${SMA_APP}

Launch Engage Application
    Log To Console    Launching Engage Application
    ${engageApplication}=    Open Application  ${APPIUM SERVER URL}  udid=${udid}  automationName=${ANDROID_AUTOMATION_NAME}    platformName=${ANDROID_PLATFORM_NAME}  appPackage=${package_DCS}  appActivity=${package_DCS}.MainActivity  appWaitActivity=*    alias=Engage
    Sleep    5
#      app=${DCS_APP}
Verify user should be on home page
    Log To Console    Verifying HomePage
    AppiumLibrary.Wait Until Page Contains Element  xpath=//android.widget.TextView[@text="Home"]  timeout=${WAIT_TIME_OUT}




#Check and Install Application
#    [Arguments]    ${apk_path}    ${PACKAGE_NAME}
#    [Documentation]    Check if the app is installed, and install it if not.
#    Log To Console    Installing Application
#    Run Process    adb    start-server
#    Log To Console    Getting Packages
#    ${packages_list}    Run Process    adb    shell    pm list packages
#    Log To Console    ${packages_list}
#    Run Process    adb    kill-server
#    Log To Console    Checking package:${PACKAGE_NAME} exists
#    ${app_installed}    Run Keyword And Return Status    Should Contain    ${packages_list}    ${PACKAGE_NAME}
#    Log To Console    App Status: ${app_installed}
#    Run Keyword If    not ${app_installed}    Install Application    ${apk_path}



