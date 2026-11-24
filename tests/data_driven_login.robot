*** Settings ***
Resource        ../utilities/browser_manager.resource
Resource        ../pages/login_page.resource

Test Setup      Launch Application
Test Teardown   Close Application
Test Template   Validate Invalid Login Attempt
Test Tags      regression    datadriven


*** Test Cases ***
# Test Case Name                    Username            Password        Expected Error Message
Locked Out User Login               locked_out_user     secret_sauce    Sorry, this user has been locked out.
Invalid Password Login              standard_user       wrong_pass      Username and password do not match
Empty Username Login                ${EMPTY}            secret_sauce    Username is required
Empty Password Login                standard_user       ${EMPTY}        Password is required


*** Keywords ***
Validate Invalid Login Attempt
    [Arguments]    ${username}    ${password}    ${expected_error}
    Login To Application    ${username}    ${password}
    Verify Login Error Message    ${expected_error}
