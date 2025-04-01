*** Settings ***
Library     RequestsLibrary
Library    jsonpath
Library    JSONLibrary
Library  Collections
Library  BuiltIn
Resource    ../../Automation/Resources/Variables/apiVariables.robot
Resource  ../../Automation/Resources/Keywords/apiKeywords.robot
Library    ../../Automation/Resources/pyLibs/pythonKeywords.py
Suite Setup  GenerateToken

*** Test Cases ***
TC_CreateCredential
    [Documentation]    Create Credential
    [Tags]    Sprint    Sanity     Regression
    ${headers}    Create Dictionary    Accept=application/json;version=1    Content-Type=application/json    Authorization=Bearer ${token_Admin}    alle-subscription-key=996cf1b917154e5e8e23308d90ad08b5
    ${UserID}    generateGuid
    Log    ${UserID}
    Set Global Variable    ${UserID}
    ${phnNumber}    randomPhnNumber
    ${attributes}        Create Dictionary    SiteId=0    SiteName=My Site Name
    ${body}    Create Dictionary    userId=${UserID}    mobileNumber=+1${phnNumber}    cardFormat=26A    facilityCode=0    issueCode=0    Attributes=${attributes}
    Log    ${body}
    ${data}    Evaluate    json.dumps(${body},indent=2)    json
    Log    ${data}
    ${response}    post on session  APIClient   ${createCred}    headers=${headers}    data=${data}
    Log    ${response.content}
    ${CredID}    GetElementFromResponse    ${response}    credentialId
    Set Global Variable    ${CredID}
    ValidateResponseCode    ${response}    201
    ValidateCreateCredentialResponseContent    ${response}

TC_GetCredentialByCredentialID
    [Documentation]    Get Credential by Credential ID
    [Tags]    Sprint    Sanity     Regression
    ${headers}    Create Dictionary    Accept=application/json;version=1    Content-Type=application/json    Authorization=Bearer ${token_Admin}    alle-subscription-key=996cf1b917154e5e8e23308d90ad08b5
    ${response}    get on session    APIClient    ${base_url}${getCredbyCredId}${CredID}    headers=${headers}
    Log    ${response.content}
    ValidateResponseCode    ${response}    200
    ValidateGetCredentialResponseContent    ${response}

TC_GetCredentialByUserID
    [Documentation]    Get Credential by UserID
    [Tags]    Sprint    Sanity     Regression
    ${headers}    Create Dictionary    Accept=application/json;version=1    Content-Type=application/json    Authorization=Bearer ${token_Admin}    alle-subscription-key=996cf1b917154e5e8e23308d90ad08b5
    ${response}    get on session    APIClient    ${base_url}${getCredbyUserId}${UserID}    headers=${headers}
    Log    ${response.content}
    ValidateResponseCode    ${response}    200
    ValidateGetCredentialResponseContent    ${response}

TC_GetCredentialByCredentialIDUsingInvalidCredId_CredNotCreated
    [Documentation]    Get Credential by Credential ID
    [Tags]    Sprint    Sanity     Regression
    ${CredID}    generateGuid
    Log    ${CredID}
    ${headers}    Create Dictionary    Accept=application/json;version=1    Content-Type=application/json    Authorization=Bearer ${token_Admin}    alle-subscription-key=996cf1b917154e5e8e23308d90ad08b5
    ${response}    get on session    APIClient    ${base_url}${getCredbyCredId}${CredID}    headers=${headers}      expected_status=404
    Log    ${response.content}
    ValidateResponseCode    ${response}    404
    ${resp}    Convert to string      ${response.content}
    Should contain      ${resp}     The requested credential was not found.

TC_GetCredentialByCredentialIDUsingInvalidCredId
    [Documentation]    Get Credential by Credential ID
    [Tags]    Sprint    Sanity     Regression
    ${headers}    Create Dictionary    Accept=application/json;version=1    Content-Type=application/json    Authorization=Bearer ${token_Admin}    alle-subscription-key=996cf1b917154e5e8e23308d90ad08b5
    @{lst}    Create List    d3a35ada-1fe9-4b02-9644-    d3a35ada-1fe9-4b02&9644$d5d205ab65de        null
    FOR  ${MyItem}  IN  @{lst}
        Log  ${MyItem}
        ${response}    get on session    APIClient    ${base_url}${getCredbyCredId}${MyItem}    headers=${headers}      expected_status=404
        Log    ${response.content}
        ValidateResponseCode    ${response}    404
    END

TC_GetCredentialByUserIDUsingInvalidUserId_CredNotCreated
    [Documentation]    Get Credential by UserID using Invalid UserId
    [Tags]    Sprint    Sanity     Regression
    ${UserID}    generateGuid
    Log    ${UserID}
    ${headers}    Create Dictionary    Accept=application/json;version=1    Content-Type=application/json    Authorization=Bearer ${token_Admin}    alle-subscription-key=996cf1b917154e5e8e23308d90ad08b5
    ${response}    get on session    APIClient    ${base_url}${getCredbyUserId}${UserID}    headers=${headers}      expected_status=404
    Log    ${response.content}
    ValidateResponseCode    ${response}    404
    ${resp}    Convert to string      ${response.content}
    Should contain      ${resp}     The requested user is not associated with credential.

TC_GetCredentialByUserIDUsingInvalidUserId
    [Documentation]    Get Credential by UserID using Invalid UserId
    [Tags]    Sprint    Sanity     Regression
    ${UserID}    generateGuid
    Log    ${UserID}
    ${headers}    Create Dictionary    Accept=application/json;version=1    Content-Type=application/json    Authorization=Bearer ${token_Admin}    alle-subscription-key=996cf1b917154e5e8e23308d90ad08b5
    @{lst}    Create List    d3a35ada-1fe9-4b02-9644-    d3a35ada-1fe9-4b02&9644$d5d205ab65de           null
    FOR  ${MyItem}  IN  @{lst}
        Log  ${MyItem}
        ${response}    get on session    APIClient    ${base_url}${getCredbyUserId}${MyItem}    headers=${headers}      expected_status=404
        Log    ${response.content}
        ValidateResponseCode    ${response}    404
    END

TC_GetCredentialByCredentialIDByManager
     [Documentation]    Get Credential by Credential ID By Manager
     [Tags]    Sprint    Sanity     Regression
     ${headers}    Create Dictionary    User-Agent=${User-Agent}    Accept=application/json;version=1    Content-Type=application/json    Authorization=Bearer ${token_Manager}    alle-subscription-key=996cf1b917154e5e8e23308d90ad08b5
     ${response}    get on session    APIClient    ${base_url}${getCredbyCredId}e2942e85-b6e9-4624-ae01-f62659a6065e    headers=${headers}      expected_status=403
     Log    ${response.content}
     ValidateResponseCode    ${response}    403
     ${resp}    Convert to string      ${response.content}
     Should contain      ${resp}     ${403_Error}

TC_GetCredentialByUserIDByManager
     [Documentation]    Get Credential by UserID By Manager
     [Tags]    Sprint    Sanity     Regression
     ${headers}    Create Dictionary    User-Agent=${User-Agent}    Accept=application/json;version=1    Content-Type=application/json    Authorization=Bearer ${token_Manager}    alle-subscription-key=996cf1b917154e5e8e23308d90ad08b5
     ${response}    get on session    APIClient    ${base_url}${getCredbyUserId}${UserID}    headers=${headers}      expected_status=403
     Log    ${response.content}
     ValidateResponseCode    ${response}    403
     ${resp}    Convert to string      ${response.content}
     Should contain      ${resp}     ${403_Error}

TC_GetCredentialByCredentialIDByOperator
     [Documentation]    Get Credential by Credential ID
     [Tags]    Sprint    Sanity     Regression
     ${headers}    Create Dictionary    User-Agent=${User-Agent}    Accept=application/json;version=1    Content-Type=application/json    Authorization=Bearer ${token_Operator}    alle-subscription-key=996cf1b917154e5e8e23308d90ad08b5
     ${response}    get on session    APIClient    ${base_url}${getCredbyCredId}${CredID}    headers=${headers}      expected_status=403
     Log    ${response.content}
     ValidateResponseCode    ${response}    403
     ${resp}    Convert to string      ${response.content}
     Should contain      ${resp}     ${403_Error}

TC_GetCredentialByUserIDByOperator
     [Documentation]    Get Credential by UserID By Operator
     [Tags]    Sprint    Sanity     Regression
     ${headers}    Create Dictionary    User-Agent=${User-Agent}    Accept=application/json;version=1    Content-Type=application/json    Authorization=Bearer ${token_Operator}    alle-subscription-key=996cf1b917154e5e8e23308d90ad08b5
     ${response}    get on session    APIClient    ${base_url}${getCredbyUserId}${UserID}    headers=${headers}      expected_status=403
     Log    ${response.content}
     ValidateResponseCode    ${response}    403
     ${resp}    Convert to string      ${response.content}
     Should contain      ${resp}     ${403_Error}

TC_ResendInvite
    [Documentation]    Get Credential by UserID
    [Tags]    Sprint    Sanity     Regression
    ${headers}    Create Dictionary    Accept=application/json;version=1    Content-Type=application/json    Authorization=Bearer ${token_Admin}    alle-subscription-key=996cf1b917154e5e8e23308d90ad08b5
    ${response}    post on session    APIClient    ${base_url}${resendInvite}${userId}/resendinvite   headers=${headers}       expected_status=204
    Log    ${response.content}
    ValidateResponseCode    ${response}    204

TC_ResendInvite_InvalidUser_CredNotCreated
    [Documentation]    Get Credential by UserID using Invalid UserId
    [Tags]    Sprint    Sanity     Regression
    ${UserID}    generateGuid
    Log    ${UserID}
    ${headers}    Create Dictionary    Accept=application/json;version=1    Content-Type=application/json    Authorization=Bearer ${token_Admin}    alle-subscription-key=996cf1b917154e5e8e23308d90ad08b5
    ${response}    post on session    APIClient    ${base_url}${resendInvite}${userId}/resendinvite   headers=${headers}       expected_status=404
    ValidateResponseCode    ${response}    404
    ${resp}    Convert to string      ${response.content}
    Should contain      ${resp}     The requested user is not associated with credential.

TC_ResendInviteUsingInvalidUserId
    [Documentation]    Get Credential by UserID using Invalid UserId
    [Tags]    Sprint    Sanity     Regression
    ${UserID}    generateGuid
    Log    ${UserID}
    ${headers}    Create Dictionary    Accept=application/json;version=1    Content-Type=application/json    Authorization=Bearer ${token_Admin}    alle-subscription-key=996cf1b917154e5e8e23308d90ad08b5
    @{lst}    Create List    d3a35ada-1fe9-4b02-9644-    d3a35ada-1fe9-4b02&9644$d5d205ab65de           null
    FOR  ${MyItem}  IN  @{lst}
        Log  ${MyItem}
        ${response}    post on session    APIClient    ${base_url}${resendInvite}${MyItem}    headers=${headers}      expected_status=404
        ValidateResponseCode    ${response}    404
    END
