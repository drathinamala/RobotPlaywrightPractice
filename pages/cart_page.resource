*** Settings ***
Library     Browser
Resource    ../utilities/custom_actions.resource
Resource    ../utilities/wait_helpers.resource


*** Variables ***
${CART_LIST}            css=.cart_list
${CHECKOUT_BUTTON}      id=checkout


*** Keywords ***
Verify Product Is In Cart
    [Arguments]    ${product_name}
    Wait Until Element Is Ready    ${CART_LIST}
    Get Text    ${CART_LIST}    contains    ${product_name}

Proceed To Checkout
    Safe Click    ${CHECKOUT_BUTTON}
