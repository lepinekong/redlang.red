Red [
    Title: "web-screenshot.red"
]

do read http://redlang.red/file-io.red
do read http://redlang.red/expand-string

.web-screenshot: function[>Url >Output-folder >Output-file /no-wait][

    Url: >Url ; http://miniapps.red/
    Output-folder: >Output-folder ; {C:\rebol\.system\test\} 
    Output-file: >Output-file ; %test-new.png 

    if not exists? red-output-folder: to-red-file Output-folder [
        make-dir/deep red-output-folder
    ]    

    ; call {"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"  
    ; --screenshot=C:\rebol\.system\test\test-new.png http://miniapps.red/ 
    ; --headless --disable-gpu"}

    command: .expand-string {<%Chrome%> --screenshot=<%Output-folder%><%Output-file%> <%Url%> --headless --disable-gpu} [
        Chrome: {"C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"}
        Url: >Url ; http://miniapps.red/
        Output-folder: >Output-folder ; {C:\rebol\.system\test\} 
        Output-file: >Output-file ; %test-new.png        
    ]

    ;?? command

    either no-wait [
        call command
    ][
        call/wait command
    ]
    return to-red-file rejoin [Output-folder Output-file]
]

Web-Screenshot: :.web-screenshot
webscreenshot: :.web-screenshot