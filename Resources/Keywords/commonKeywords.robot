*** Settings ***
Library  AppiumLibrary
Library  SeleniumLibrary
Library    Process
Resource    ../../Resources/Configs/AppiumConfigs.robot



*** Keywords ***
Open Test Application
    [Documentation]    Open the testing application
    [Arguments]    ${PLATFORM_NAME}
    Run Keyword If    '${PLATFORM_NAME}' == '${ANDROID_PLATFORM_NAME}'    Open Android Application
    Run Keyword If    '${PLATFORM_NAME}' == '${IOS_PLATFORM_NAME}'    Open IOS Application

Open Android Application
    [Documentation]    Open the Android application
    Check And Install Application    ${SMA_APP_apk}    ${package_SMA}
    Launch SMA Application
    Set Appium Timeout    ${WAIT_TIME_OUT}


Open IOS Application
    [Documentation]    Open the iOS application
    Open Application    ${APPIUM_SERVER_URL}    automationName=${IOS_AUTOMATION_NAME}    platformName=${IOS_PLATFORM_NAME}    platformVersion=${IOS_PLATFORM_VERSION}    deviceName=${IOS_DEVICE_NAME}    app=${IOS_APP}
    Set Appium Timeout    ${WAIT_TIME_OUT}

Check and Install Application
    [Documentation]    This keyword checks and install the app if it is not already installed
    [Arguments]    ${apk_path}    ${appPackage}
    Run Process    adb    start-server
    ${result}    Run Process    adb     shell    pm list packages    stdout=stdout.txt
    ${packages_list}    Set Variable    ${result.stdout}
    Log To Console    ${packages_list}
    ${app_installed}    Run Keyword And Return Status    Should Contain    ${packages_list}    ${appPackage}
    Log To Console    App Status: ${app_installed}
    Run Process    adb    start-server
    Run Keyword If    not ${app_installed}    Run Process    adb    install    ${apk_path}
    Run Keyword If    not ${app_installed}    Sleep    10
    Run Keyword If    not ${app_installed}    Log To Console    App Installed Successfully
#    ${return_code}    Convert To Integer    ${return_code}
#    Should Be Equal As Strings    ${return_code}    Success

Launch SMA Application
    Log To Console    Launching SMA Application
    Open Application  ${APPIUM SERVER URL}    alias=QSA    udid=${udid}  automationName=${ANDROID_AUTOMATION_NAME}    platformName=${ANDROID_PLATFORM_NAME}    appPackage=${package_SMA}  appActivity=${package_SMA}.MainActivity  appWaitActivity=*
    Sleep    10
#      app=${SMA_APP}

Launch Engage Application
    Log To Console    Launching Engage Application
    Open Application  ${APPIUM SERVER URL}    alias=Engage  udid=${udid}  automationName=${ANDROID_AUTOMATION_NAME}    platformName=${ANDROID_PLATFORM_NAME}  appPackage=${package_DCS}  appActivity=${package_DCS}.MainActivity  appWaitActivity=*
    Sleep    10

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