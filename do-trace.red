Red [
    Title: "do-trace.red"
    duplicates: [
        "do-trace"
        "lib-debug.red"
        "debug.red"
    ]
    Build: 1.0.0.4
    History: {
        - added .do-trace-update-lines
        - added file in line pause
    }
]

do http://redlang.red/lib-files

.do-trace: function [.line-number [integer!] '.block [word! block! unset!] .file [file! url! string!]
/filter that-contains [string! file! url!]
/update .script-path
][

	{

        #### Example:
        - [x] [1]. 
        
```
        f: function [.file .argument][
            do-trace 2 [
                probe .argument
            ] .file
        ]
        f %test-this-file.red "test this file"
```

        - [x] [2]. 
        
```
        g: function [.file .argument][
            do-trace/filter 2 [
                probe .argument
            ] .file "test" 
        ]
        g %this-should-not-be-traced.red "this file should not be traced"

```


    }

    if update [
        .do-trace-update-lines .script-path
    ]

    file: form .file
    if filter [
            either not find file that-contains [exit][
        ]
    ]

    switch type?/word get/any '.block [
        unset! [
            print {TODO:}
        ]
        block! [

            .do-events/no-wait
            print newline
            print "---------------------------------"
            print  [file "line" .line-number ": "]
            .do-events/no-wait
            do :.block
            ask rejoin ["pause in " file " on line " .line-number "..."]
        ]
    ]

]

do-trace: :.do-trace

; dependencies

.do-events: function [
    
	{Launch the event loop, blocks until all windows are closed} 
	/no-wait "Process an event in the queue and returns at once" 
	return: [logic! word!] 
	/local result 
	win
][
    try [
        either no-wait [
            do-events/no-wait
        ][
            do-events
        ]
    ]
] 

.do-trace-update-lines: function[script-path][

    source-code-lines: read/lines script-path
    

    forall source-code-lines [

        line-number: index? source-code-lines
        source-code-line: source-code-lines/1
        old-source-code-line: source-code-line
        source-code-line: replace-line-number source-code-line line-number
        

        either line-number = 1 [
            write %temp.red source-code-line
        ][
            write/append %temp.red source-code-line
        ]

        write/append %temp.red rejoin ["" newline]
        
    ]


    source-code: read %temp.red
    parse source-code parse-rule: [
        (count: 0)
        any [
            to "do-trace" thru "[" (count: count + 1)
            thru "]" (count: count - 1)
            thru "%" start: copy old-filename [to ".red" | to ".read"] copy extension [ to " " | to "^/"] ending:
            (

                if (old-filename <> {" start: copy old-filename [to "}) [

                    script-filename: .get-short-filename script-path                     
                    change/part start script-filename ending
                ]

            )

        ]
    ]   

    write %temp2.red source-code
    write-clipboard source-code
    print "do-trace update written to clipboard"
]

do-trace-update-lines: :.do-trace-update-lines

; dependencies

.replace-line-number: function[source-code-line new-line-number][
    
    parse-rule: [   
        thru "do-trace" thru " "  start: copy line-number to " " ending: (
            try [
                line-number: to-integer to-float line-number
                change/part start new-line-number ending 
            ]
            count: 0
        )

    ]

    parse source-code-line parse-rule

    return source-code-line    
]

replace-line-number: :.replace-line-number

