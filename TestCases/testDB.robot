*** Settings ***
Library    DatabaseLibrary
Library    pymysql
Resource   ../../Automation/Resources/Variables/dbVariables.robot


*** Variables ***
${sqlQuery}    select LicenseID from access_management.license where CustomerId = 330952 and status=1;

*** Test Cases ***
Connect To Database And Query
    [Documentation]    Connect to a MySQL database and execute a query
    Connect To Database    dbapiModuleName=pyodbc    dbName=${DBName}    dbHost=${DBHost}    dbPort=${DBPort}    dbUsername=${DBUser}    dbPassword=${DBPass}    dbName=${DBName}
    @{result}    Query    ${sqlQuery}
    Log Many    @{result}
    Disconnect From Database

