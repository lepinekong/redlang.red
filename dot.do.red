Red [
    Title: "do.red"
    Builds: [
        0.0.0.1.8 {Initial Build / Iteration 8}
    ]
]

if not value? '.do [

    .do: function [

        {.do/redlang allows you to load multiples redlang libraries with a shortcut syntax.} 
        'value [any-type!] 
        /expand "Expand directives before evaluation" 
        /args {If value is a script, this will set its system/script/args} 
        arg "Args passed to a script (normally a string)" 
        /next {Do next expression only, return it, update block word} 
        position [word!] "Word updated with new block position"
        /redlang {Examples: 
            .do/redlang cd
            .do/redlang [cd copy-files]
            .do/redlang/silent [cd copy-files]
        }
        /silent {Don't print command}
        /_debug {debug mode for developer only}

    ][
        value: :value

        if redlang [

            either block? value [

                new-value: copy value

                forall new-value [

                    command: copy []
                    main-command: copy ".do/redlang"
                    if expand [
                        main-command: rejoin [main-command "/expand"]
                    ]
                    if args [
                        main-command: rejoin [main-command "/args"]
                    ]
                    if next[
                        main-command: rejoin [main-command "/next"]
                    ]
                    if silent[
                        main-command: rejoin [main-command "/silent"]
                    ]
                    if _debug[
                        main-command: rejoin [main-command "/_debug"]
                    ] 

                    command: to block! main-command

                    append command compose [(new-value/1)]

                    if args [
                        append command to-word 'arg
                    ]
                    if next [
                        append command to-word 'position
                    ]   

                    if _debug [
                        msg-debug: {.do line 63: }
                        print rejoin [msg-debug command]
                    ]
                    do command
                ]
                exit ; if missing => bug
                
            ][
                url-string: form value

                if not find url-string "redlang" [
                    either find url-string "https" [
                        parse url-string [
                            thru "https://" start: (insert start "redlang.red/")
                        ]
                        value: to-url url-string
                    ][
                        value: to-url rejoin [https://redlang.red/ url-string]
                    ]
                ]
            ]
        ]

        command: copy []

        main-command: copy "do"
        
        if expand [
            main-command: rejoin [main-command "/expand"]
        ]
        if args [
            main-command: rejoin [main-command "/args"]
        ]
        if next[
            main-command: rejoin [main-command "/next"]
        ]

        command: to block! main-command

        append command compose [(value)]

        if args [
            append command to-word 'arg
        ]
        if next [
            append command to-word 'position
        ]   

        unless silent [
            msg-debug: ""
            if _debug [msg-debug: {.do line 112: }]
            print rejoin [msg-debug command]
        ]

        do command        

    ]  
]     

