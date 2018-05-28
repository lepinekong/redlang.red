Red [
    Title: "debug.red"
    Alias: [
        "do-trace.red"
        "lib-debug.red"
    ]    
]

.do-trace: function [.line-number [integer!] '.block [word! block! unset!] .file [file! url! string!]
/filter that-contains [string! file! url!]
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
            print "---------------------------------"
            print  [file "line" .line-number ": "]
            .do-events/no-wait
            do :.block
            ask "pause..."
        ]
    ]

]

do-trace: :.do-trace

; dependencies

.do-events: function [
    
	{Launch the event loop, blocks until all windows are closed} 
	/no-wait "Process an event in the queue and returns at once" 
	return: [logic! word!] "Returned value from last event" 
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
