Red [
    Title: "take-screenshot.2.red"
        0.0.0.1.2 {Bug when adding doc:     
        {Take web-screenshot with google chrome
    Usage: take-screenshot https://google.com c:\test\test.png}
    }    
        0.0.0.1.1 {Initial version}
]

take-screenshot: function [  
    {Take web-screenshot with google chrome
    Usage: take-screenshot https://google.com c:\test\test.png}    
    >url {example: https://google.com}
    >file {example: c:\test\test.png}
    /window-size >window-size [pair! string!] {example: 1920x1080 or "1920,1080"}
][

    .local-file: to-local-file form >file

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

    unless value? 'get-chrome-path [
        do https://redlang.red/chrome/get-chrome-path.red
    ]
    chrome-path: get-chrome-path

    command: rejoin [
        chrome-path { } >url   
        { } {--screenshot=} {"} .local-file {"} 
        { } {--headless}  
        { } {--window-size=} >window-size 
        { } {--hide-scrollbars --disable-gpu}
    ]

    call/wait command

    output: to-local-file clean-path to-red-file .local-file
    print ["screenshot" "in" output]

]


