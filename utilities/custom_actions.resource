*** Settings ***
Library     Browser
Resource    wait_helpers.resource


*** Keywords ***
# --- CLICK WRAPPERS ---
Safe Click
    [Arguments]    ${selector}
    Wait Until Element Is Ready    ${selector}
    Click    ${selector}

Double Click On Element
    [Arguments]    ${selector}
    Wait Until Element Is Ready    ${selector}
    Click With Options    ${selector}    clickCount=2

Right Click On Element
    [Arguments]    ${selector}
    Wait Until Element Is Ready    ${selector}
    Click With Options    ${selector}    button=right

Force Click Hidden Or Covered Element
    [Arguments]    ${selector}
    Click With Options    ${selector}    force=True

# --- TYPING & SEND KEYS WRAPPERS ---
Safe Fill Text
    [Arguments]    ${selector}    ${text}
    Wait Until Element Is Ready    ${selector}
    Clear Text    ${selector}
    Fill Text    ${selector}    ${text}

Type Text Character By Character
    [Arguments]    ${selector}    ${text}    ${delay}=100ms
    Wait Until Element Is Ready    ${selector}
    Type Text    ${selector}    ${text}    delay=${delay}

Send Keyboard Key
    [Arguments]    ${selector}    ${key}
    Wait Until Element Is Ready    ${selector}
    Press Keys    ${selector}    ${key}

# --- MOUSE & SCROLL ACTIONS ---
Hover Over Element
    [Arguments]    ${selector}
    Wait Until Element Is Ready    ${selector}
    Hover    ${selector}

Drag And Drop Element
    [Arguments]    ${source_selector}    ${target_selector}
    Wait Until Element Is Ready    ${source_selector}
    Wait Until Element Is Ready    ${target_selector}
    Drag And Drop    ${source_selector}    ${target_selector}

Scroll To Element
    [Arguments]    ${selector}
    Scroll To Element    ${selector}

# --- DROPDOWN & CHECKBOX WRAPPERS ---
Select Dropdown By Label
    [Arguments]    ${selector}    ${label_text}
    Wait Until Element Is Ready    ${selector}
    Select Options By    ${selector}    label    ${label_text}

Select Dropdown By Value
    [Arguments]    ${selector}    ${value}
    Wait Until Element Is Ready    ${selector}
    Select Options By    ${selector}    value    ${value}

# --- PAGINATION HELPER ---
Find Item Across Pages
    [Arguments]    ${item_selector}    ${next_button_selector}    ${max_pages}=10
    FOR    ${page}    IN RANGE    1    ${max_pages} + 1
        ${count}=    Get Element Count    ${item_selector}
        IF    ${count} > 0
            Safe Click    ${item_selector}
            RETURN
        END
        ${next_state}=    Get Element States    ${next_button_selector}
        Exit For Loop If    'disabled' in ${next_state}
        Safe Click    ${next_button_selector}
    END
    Fail    Item '${item_selector}' was not found after checking ${max_pages} pages.
