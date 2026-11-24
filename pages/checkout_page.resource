*** Settings ***
Library     Browser
Resource    ../utilities/custom_actions.resource
Resource    ../utilities/wait_helpers.resource


*** Variables ***
${FIRST_NAME_INPUT}     id=first-name
${LAST_NAME_INPUT}      id=last-name
${POSTAL_CODE_INPUT}    id=postal-code
${CONTINUE_BUTTON}      id=continue
${FINISH_BUTTON}        id=finish
${COMPLETE_HEADER}      css=.complete-header


*** Keywords ***
Fill Checkout Information
    [Arguments]    ${first_name}    ${last_name}    ${postal_code}
    Safe Fill Text    ${FIRST_NAME_INPUT}    ${first_name}
    Safe Fill Text    ${LAST_NAME_INPUT}    ${last_name}
    Safe Fill Text    ${POSTAL_CODE_INPUT}    ${postal_code}
    Safe Click    ${CONTINUE_BUTTON}

Complete Order And Verify Confirmation
    Safe Click    ${FINISH_BUTTON}
    Wait Until Element Is Ready    ${COMPLETE_HEADER}
    Get Text    ${COMPLETE_HEADER}    ==    Thank you for your order!
