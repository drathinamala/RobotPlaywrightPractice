*** Settings ***
Library     Browser
Resource    ../utilities/custom_actions.resource
Resource    ../utilities/wait_helpers.resource


*** Variables ***
${USERNAME_INPUT}       id=user-name
${PASSWORD_INPUT}       id=password
${LOGIN_BUTTON}         id=login-button
${LOGIN_ERROR_MSG}      [data-test="error"]


*** Keywords ***
Login To Application
    [Arguments]    ${username}    ${password}
    Safe Fill Text    ${USERNAME_INPUT}    ${username}
    Safe Fill Text    ${PASSWORD_INPUT}    ${password}
    Safe Click    ${LOGIN_BUTTON}

Verify Login Error Message
    [Arguments]    ${expected_error}
    Wait Until Element Is Ready    ${LOGIN_ERROR_MSG}
    Get Text    ${LOGIN_ERROR_MSG}    contains    ${expected_error}
