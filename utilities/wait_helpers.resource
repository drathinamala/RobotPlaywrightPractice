*** Settings ***
Library     Browser


*** Keywords ***
Wait Until Element Is Ready
    [Arguments]    ${selector}    ${timeout}=10s
    Wait For Elements State    ${selector}    visible    timeout=${timeout}
    Wait For Elements State    ${selector}    enabled    timeout=${timeout}

Wait Until Element Disappears
    [Arguments]    ${selector}    ${timeout}=10s
    Wait For Elements State    ${selector}    hidden    timeout=${timeout}

Wait Until Text Appears On Page
    [Arguments]    ${expected_text}    ${timeout}=10s
    Wait For Elements State    text=${expected_text}    visible    timeout=${timeout}

Wait For Url To Contain
    [Arguments]    ${partial_url}    ${timeout}=10s
    Wait Until Keyword Succeeds    ${timeout}    500ms    Get Url    contains    ${partial_url}

Wait For Page Load Complete
    Wait For Load State    networkidle

Retry Flaky Action
    [Arguments]    ${keyword_name}    @{args}
    Wait Until Keyword Succeeds    3x    2s    ${keyword_name}    @{args}
