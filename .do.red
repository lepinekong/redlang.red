Red [
    Title: "do.red"
    Builds: [
        0.0.0.1 {Initial Build}
    ]
    Iterations: [
        40 {Debug 48 for expand-string}
        36 {Execute command in block because exit code missing}
        28 {Revert to 25}
        23 {Individualize do/redlang in block}
        22 {Revert to 18}
        19 {Block type}
        10 {Fixed}
        9 {Revert to 4}
    ]
]


if not value? '.do [
    .do: function [
        {Evaluates a value, returning the last evaluation result} 
        'value [any-type!] 
        /expand "Expand directives before evaluation" 
        /args {If value is a script, this will set its system/script/args} 
        arg "Args passed to a script (normally a string)" 
        /next {Do next expression only, return it, update block word} 
        position [word!] "Word updated with new block position"
        /redlang
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
                    command: copy reduce [load main-command] ; don't forget reduce otherwise bug !!

                    append command compose [(new-value/1)]

                    if args [
                        append command to-word 'arg
                    ]
                    if next [
                        append command to-word 'position
                    ]   
                    do command
                ]
                exit ; missing => bug in 0.0.0.1.36 => added in 0.0.0.1.37
                
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
        
        either args [
            either expand [
                either next [
                    command: compose [do/args/expand/next]
                ][
                    command: compose [do/args/expand]
                ]
            ][
                either next [
                    command: compose [do/args/next] ; ok
                ][
                    command: compose [do/args] ; ok
                ]
                
            ]
            
        ][
            either expand [
                either next [
                    command: compose [do/expand/next]
                ][
                    command: compose [do/expand]
                ]
                
            ][
                either next [
                    command: compose [do/next]
                ][
                    command: compose [do]
                ]
            ]
        ]

        append command compose [(value)]

        if args [
            append command 'arg
        ]

        if next [
            append command 'position
        ]

        do command
        ;reduce command ; TODO: compare performance
    ]  
]     

