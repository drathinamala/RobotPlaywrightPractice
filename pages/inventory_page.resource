*** Settings ***
Library     Browser
Resource    ../utilities/custom_actions.resource
Resource    ../utilities/wait_helpers.resource


*** Variables ***
${PAGE_HEADER}          css=.title
${SORT_DROPDOWN}        [data-test="product-sort-container"]
${CART_BADGE}           css=.shopping_cart_badge
${CART_LINK}            css=.shopping_cart_link


*** Keywords ***
Verify Inventory Page Loaded
    Wait Until Element Is Ready    ${PAGE_HEADER}
    Get Text    ${PAGE_HEADER}    ==    Products

Sort Products By
    [Arguments]    ${sort_option}
    Select Dropdown By Label    ${SORT_DROPDOWN}    ${sort_option}

Add Product To Cart By Name
    [Arguments]    ${product_name}
    ${add_btn}=    Set Variable    xpath=//div[text()='${product_name}']/ancestor::div[@class='inventory_item']//button
    Safe Click    ${add_btn}

Verify Cart Count Is
    [Arguments]    ${expected_count}
    Wait Until Element Is Ready    ${CART_BADGE}
    Get Text    ${CART_BADGE}    ==    ${expected_count}

Open Shopping Cart
    Safe Click    ${CART_LINK}
