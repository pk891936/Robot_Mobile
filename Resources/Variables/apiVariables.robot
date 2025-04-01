
*** Variables ***
${env}   test
${base_url}  https://api.securewebserv.com/${env}/smc-api
${Auth_tokenPath}  /authentication/token
${createCred}  /credentials/mobile/basic
${getCredbyCredId}  /credentials/mobile/basic/
${getCredbyUserId}  /credentials/mobile/basic/users/
${resendInvite}  /credentials/mobile/basic/users/
${CredID}    ${EMPTY}
${cred}  173e50c1-c8e6-4766-81c8-ae9f19a7d9f4
${userId}    ${EMPTY}
${Admin}    test_api_only_specflow_admin@sharklasers.com
${Manager}    test_api_only_specflow_manager@sharklasers.com
${Operator}    test_api_only_specflow_operator@sharklasers.com
${pass}    Orca123456
${token_Admin}    ${EMPTY}
${token_Manager}    ${EMPTY}
${token_Operator}    ${EMPTY}
${MyItem}    ${EMPTY}
${User-Agent}    Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36
${403_Error}    You do not have permission to access the requested resource. Please contact your site administrator for more information (203).