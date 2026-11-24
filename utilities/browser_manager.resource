*** Settings ***
Library     Browser
Resource    ../testdata/env_config.resource


*** Keywords ***
Launch Application
    Set Browser Timeout    ${DEFAULT_TIMEOUT}
    New Browser    ${BROWSER}    headless=${HEADLESS}
    New Context    viewport={'width': 1280, 'height': 720}
    New Page    ${BASE_URL}

Close Application
    Close Context
    Close Browser
