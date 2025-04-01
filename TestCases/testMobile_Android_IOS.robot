*** Settings ***
Documentation  Test Mobile App
Library  AppiumLibrary
Library  SeleniumLibrary
Library    Process
Library    ../../Automation/Resources/pyLibs/pythonKeywords.py
Resource    ../../Automation/Resources/Keywords/commonKeywords.robot
Resource    ../../Automation/Resources/Configs/AppiumConfigs.robot
#Test Tags  webdriver
Suite Setup  Open Test Application    ${PLATFORM_NAME}
Suite Teardown    Close All Applications


*** Test Cases ***
Test to initiate web and mobile app verification
    [Documentation]    Test to Launch Web Browser and Mobile apps
    Verify user should be on home page
    Check and Install Application    ${DCS_APP_apk}    ${package_DCS}
    Open Application  ${APPIUM SERVER URL}    alias=Engage    automationName=${ANDROID_AUTOMATION_NAME}    platformName=${ANDROID_PLATFORM_NAME}  appPackage=${package_DCS}  appActivity=${package_DCS}.MainActivity  appWaitActivity=*
    Start Activity    ${package_SMA}    ${package_SMA}.MainActivity
    Sleep   2
    Verify user should be on home page
    Start Activity    ${package_DCS}    ${package_DCS}.MainActivity
    Sleep   2





