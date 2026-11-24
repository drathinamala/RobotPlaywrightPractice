*** Settings ***
Resource        ../utilities/browser_manager.resource
Resource        ../utilities/wait_helpers.resource
Resource        ../utilities/custom_actions.resource
Resource        ../pages/login_page.resource
Resource        ../pages/inventory_page.resource
Resource        ../pages/cart_page.resource
Resource        ../pages/checkout_page.resource

Test Setup      Launch Application
Test Teardown   Close Application
Test Tags      regression


*** Test Cases ***
Complete End To End Purchase With Dropdown Sorting
    [Documentation]    Validates login, sorting products via dropdown, adding items, and completing checkout.
    [Tags]    smoke    e2e    checkout
    Given User Logs Into Sauce Demo With Valid Credentials
    When User Sorts Products By    Price (low to high)
    And User Adds Product To Cart    Sauce Labs Backpack
    And User Adds Product To Cart    Sauce Labs Bike Light
    Then Cart Badge Should Display    2
    When User Navigates To Cart And Proceeds To Checkout
    And User Completes Checkout With Details    Deepa    Rani    14226
    Then Order Confirmation Should Be Displayed

Handle Flaky Performance Glitch User With Retry Wrapper
    [Documentation]    Tests a slow/flaky user profile using our custom Retry Flaky Action wrapper.
    [Tags]    flaky    performance
    Given User Logs In With Credentials    performance_glitch_user    ${VALID_PASSWORD}
    Then Retry Flaky Action    Verify Inventory Page Loaded
    When User Performs Mouse Hover And Right Click On Product    Sauce Labs Onesie


*** Keywords ***
User Logs Into Sauce Demo With Valid Credentials
    Login To Application    ${VALID_USER}    ${VALID_PASSWORD}
    Verify Inventory Page Loaded

User Logs In With Credentials
    [Arguments]    ${username}    ${password}
    Login To Application    ${username}    ${password}

User Sorts Products By
    [Arguments]    ${sort_option}
    Sort Products By    ${sort_option}

User Adds Product To Cart
    [Arguments]    ${product_name}
    Add Product To Cart By Name    ${product_name}

Cart Badge Should Display
    [Arguments]    ${expected_count}
    Verify Cart Count Is    ${expected_count}

User Navigates To Cart And Proceeds To Checkout
    Open Shopping Cart
    Verify Product Is In Cart    Sauce Labs Backpack
    Proceed To Checkout

User Completes Checkout With Details
    [Arguments]    ${first_name}    ${last_name}    ${postal_code}
    Fill Checkout Information    ${first_name}    ${last_name}    ${postal_code}

Order Confirmation Should Be Displayed
    Complete Order And Verify Confirmation

User Performs Mouse Hover And Right Click On Product
    [Arguments]    ${product_name}
    ${product_title}=    Set Variable    xpath=//div[text()='${product_name}']
    Hover Over Element    ${product_title}
    Right Click On Element    ${product_title}
