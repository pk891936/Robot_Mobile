*** Settings ***
Library    RequestsLibrary
Library    jsonpath
Library    JSONLibrary
Library    Collections
Resource  ../Variables/apiVariables.robot


*** Keywords ***
getAuthToken_APIOnly
    [Arguments]    ${user}    ${pass}
    ${body}    Create Dictionary    username=${user}    password=${pass}
    Log    ${body}
    ${data}    Evaluate    json.dumps(${body},indent=2)    json
    Log    ${data}
    ${headers}    Create Dictionary    Accept=application/json;version=1    Content-Type=application/json    alle-subscription-key=996cf1b917154e5e8e23308d90ad08b5
    create session  APIClient   ${base_url}     disable_warnings=1     #verify=certs.pem
    ${response}    post on session  APIClient   ${Auth_tokenPath}    data=${data}    headers=${headers}
    Log    ${response}
    ${json_resp}=   Convert String To Json    ${response.content}
    ${token}    Get Value From Json    ${json_resp}    token
    [Return]    ${token}[0]

GenerateToken
    [Documentation]    Generate Token
    ${token_Admin}    getAuthToken_APIOnly    ${Admin}    ${pass}
    Set Global Variable    ${token_Admin}
    ${token_Manager}    getAuthToken_APIOnly    ${Manager}    ${pass}
    Set Global Variable    ${token_Manager}
    ${token_Operator}    getAuthToken_APIOnly    ${Operator}    ${pass}
    Set Global Variable    ${token_Operator}

GetElementFromResponse
    [Arguments]    ${response}    ${json}
    ${json_resp}=   Convert String To Json    ${response.content}
    ${element}    Get Value From Json    ${json_resp}    ${json}
    [Return]     ${element}[0]

ValidateResponseCode
    [Arguments]    ${response}    ${expectedCode}
    ${resp_code}=   Convert To String    ${response.status_code}
    Should Be Equal    ${resp_code}    ${expectedCode}

ValidateCreateCredentialResponseContent
    [Arguments]    ${response}
    ${json_resp}=   Convert String To Json    ${response.content}
    ${keys}    Get Dictionary Keys  ${json_resp}
    Log    ${keys}
    Should Contain    ${keys}    credentialId
    Should Contain    ${keys}    cardNumber


ValidateGetCredentialResponseContent
    [Arguments]    ${response}
    ${json_resp}=   Convert String To Json    ${response.content}
    ${keys}    Get Dictionary Keys  ${json_resp}
    Log    ${keys}
    Should Contain    ${keys}    credentialId
    Should Contain    ${keys}    userId
    Should Contain    ${keys}    mobileNumber
    Should Contain    ${keys}    payloadType
    Should Contain    ${keys}    cardNumber
    Should Contain    ${keys}    facilityCode
    Should Contain    ${keys}    issueCode
    Should Contain    ${keys}    isDownloaded
    ${status}    Run Keyword And Return Status    Should Contain    ${keys}    attributes
    Run Keyword If    '${status}'=='True'    ValidateAttributeKeys    ${response}

ValidateAttributeKeys
    [Arguments]    ${response}
    ${json_resp}=   Convert String To Json    ${response.content}
    ${attributes}    Get Value From Json    ${json_resp}    attributes
    ${attributeKeys}    Get Dictionary Keys  ${attributes}[0]
    Should Contain    ${attributeKeys}    siteId
    Should Contain    ${attributeKeys}    siteName



