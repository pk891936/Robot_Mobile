*** Variables ***
${PLATFORM_NAME}              ${ANDROID_PLATFORM_NAME}
${APPIUM SERVER URL}  http://127.0.0.1:4723/wd/hub
${WAIT_TIME_OUT}  20
# Android
${udid}    38221FDJH002NT
${ANDROID_AUTOMATION_NAME}    UIAutomator2
${SMA_APP_apk}                C:/Users/ckumar2/PycharmProjects/RobotAPI/Automation/APKs/app-debug.apk
${DCS_APP_apk}                C:/Users/ckumar2/PycharmProjects/RobotAPI/Automation/APKs/DCSDemoApp-BETA-debug.apk
${package_SMA}    com.allegion.sdkdemo
${package_DCS}    com.allegionengage.dcsdemo
${ANDROID_PLATFORM_NAME}      Android
${ANDROID_DEVICE_NAME}        Pixel 6

# iOS configs
${IOS_AUTOMATION_NAME}        XCUITest
${IOS_APP}                    ${CURDIR}/../apps/SMADemoApp.app
${IOS_PLATFORM_NAME}          ios
${IOS_APP_BUNDLE_ID}          com.allegion.smademoapp
${IOS_DEVICE_NAME}            iPhone 14