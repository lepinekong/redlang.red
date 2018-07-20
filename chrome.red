Red [
    Title: "chrome.red"
    Iterations: [
        0.0.0.1.1 {Initial version}
    ]
]

get-chrome-path: function [][
    return chrome-path: rejoin [{"} get-env "programfiles(x86)" "\Google\Chrome\Application\chrome.exe" {"}]
]

chrome: function [>url][
    chrome-path: get-chrome-path
    command: rejoin [chrome-path { } >url]
    call command
]

take-screenshot: function [>url >file][
    chrome-path: get-chrome-path
    command: rejoin [chrome-path { } >url { }  {--screenshot=} >file { } {--headless --disable-gpu}]
    call command
]