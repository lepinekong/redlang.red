Red [
    Title: "take-screenshot.red"
]

take-screenshot: function [>url >file /window-size >window-size [pair! string!]][

    ;-------------------------------------------------------
    DEFAULT_WINDOW-SIZE: "1920,1080"

    if window-size [
        if pair? >window-size [
            >window-size: replace to-string >window-size "x" ","
        ]
    ]

    unless window-size [
        >window-size: DEFAULT_WINDOW-SIZE
    ]
    ;-------------------------------------------------------

    chrome-path: get-chrome-path
    command: rejoin [
        chrome-path { } >url   
        { } {--screenshot=} {"} >file {"} 
        { } {--headless}  
        { } {--window-size=} >window-size 
        { } {--hide-scrollbars --disable-gpu}
    ]

    call/wait command
]
