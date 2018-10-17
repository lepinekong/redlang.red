Red [
    Title: "do.red"
    SemVer: [1.0.0 {Alpha version}]
    Builds: [
        0.0.0.5.02.5 {alias .install/install for quickinstall}
        0.0.0.5.2.2 {performance optimization}
        0.0.0.5.2 {/codeops}
        0.0.0.5.1 {/quickinstall}
        0.0.0.3.3 {/quickrun}
    ]
]
unless value? '.do [

    .do: function [

        {.do/redlang allows you to load multiples redlang libraries with a shortcut syntax.} 
        'value [any-type! unset!] 
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
        /quickrun
        /quickinstall
        /codeops
        /silent { [DEPRECATED] Don't print command}
        /_debug {debug mode for developer only}
        /_build

    ][
        >builds: [
            0.0.0.5.2.2 {performance optimization}
            0.0.0.4.3 {
            - /silent deprecated
            - /_build added
        }]

        if _build [
            ?? >builds
            return >builds
            exit
        ]

        if _debug [
            do https://redlang.red/do-trace ; 0.0.0.5.02.6
        ]

        silent: true

        value: :value

        if redlang [

            .refinement: "redlang"
            .domain: rejoin [.refinement ".red"]

            either block? value [

                new-value: copy value

                forall new-value [

                    command: copy []
                    main-command: copy rejoin [".do/" .refinement]
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
                        msg-debug: {.do 02.main/01.redlang.red line 42: }
                        print rejoin [msg-debug command]
                    ]
                    do command
                ]
                exit ; if missing => bug
                
            ]
[
                url-string: form value

                if not find url-string .refinement [
                    either find url-string "https" [
                        parse url-string [
                            thru "https://" start: (insert start rejoin [.domain "/"])
                        ]
                        value: to-url url-string
                    ][
                        value: to-url rejoin ["https://" .domain "/" url-string]
                    ]
                ]
            ]

        ]


        if quickrun [

            .refinement: "quickrun"
            .domain: rejoin [.refinement ".red"]

            either block? value [

                new-value: copy value

                forall new-value [

                    command: copy []
                    main-command: copy rejoin [".do/" .refinement]
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
                        msg-debug: {.do 02.main/01.redlang.red line 42: }
                        print rejoin [msg-debug command]
                    ]
                    do command
                ]
                exit ; if missing => bug
                
            ]
[
                url-string: form value

                if not find url-string .refinement [
                    either find url-string "https" [
                        parse url-string [
                            thru "https://" start: (insert start rejoin [.domain "/"])
                        ]
                        value: to-url url-string
                    ][
                        value: to-url rejoin ["https://" .domain "/" url-string]
                    ]
                ]
            ]

        ]


        if quickinstall [

            .refinement: "quickinstall"
            .domain: rejoin [.refinement ".red"]

            either block? value [

                new-value: copy value

                forall new-value [

                    command: copy []
                    main-command: copy rejoin [".do/" .refinement]
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
                        msg-debug: {.do 02.main/01.redlang.red line 42: }
                        print rejoin [msg-debug command]
                    ]

                    if _debug [
                        do-trace 237 [
                            ?? command
                        ] %dot.do.6.red
                        
                    ]
                    do command
                ]
                exit ; if missing => bug
                
            ]
[
                url-string: form value

                ; 0.0.0.5.02.6
                if _debug [
                    do-trace 253 [
                        ?? .refinement
                        ?? url-string
                    ] %dot.do.6.red
                    
                ]

                if not find url-string .refinement [
                    ; !!! 0.0.0.5.02.6
                    value: copy []

                    either find url-string "https" [
                        parse url-string [
                            thru "https://" start: (insert start rejoin [.domain "/"])
                        ]
                        ; !!! 0.0.0.5.02.6
                        append value to-url url-string
                    ][
                        ; !!! 0.0.0.5.02.6
                        append value to-url rejoin ["https://" .domain "/" url-string]
                    ]

                    do-trace 274 [
                        ?? url-string
                    ] %dot.do.7.red
                    
                    ; !!! 0.0.0.5.02.6
                    ;append value to-word rejoin [".install-" url-string]

                    ; !!! 0.0.0.5.03.3
                    either find url-string "/" [
                        keyword: last split url-string "/"

                        do-trace 285 [
                            ?? keyword
                        ] %dot.do.7.red
                        replace keyword "install-" ""
                        append value to-word rejoin [".install-" keyword]
                    ][
                        append value to-word rejoin [".install-" url-string]
                    ]                    

                    ; 0.0.0.5.02.6
                    if _debug [
                        do-trace 272 [
                            ?? value
                        ] %dot.do.6.red
                        
                    ]
                ]
            ]

        ]


        if codeops [

            .refinement: "codeops"
            .domain: rejoin [.refinement ".red"]

            either block? value [

                new-value: copy value

                forall new-value [

                    command: copy []
                    main-command: copy rejoin [".do/" .refinement]
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
                        msg-debug: {.do 02.main/01.redlang.red line 42: }
                        print rejoin [msg-debug command]
                    ]
                    do command
                ]
                exit ; if missing => bug
                
            ]
[
                url-string: form value

                if not find url-string .refinement [
                    either find url-string "https" [
                        parse url-string [
                            thru "https://" start: (insert start rejoin [.domain "/"])
                        ]
                        value: to-url url-string
                    ][
                        value: to-url rejoin ["https://" .domain "/" url-string]
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

        if _debug [
            ; 0.0.0.5.02.6
            do-trace 368 [
                ?? value
                ?? command
            ] %dot.do.6.red
            
        ]

        if args [
            append command to-word 'arg
        ]
        if next [
            append command to-word 'position
        ]   

        unless silent [
            msg-debug: ""
            if _debug [msg-debug: {.do line 348: }]
            print rejoin [msg-debug command]
        ]

        ;; 0.0.0.5.02.6
        if _debug [
            do-trace 372 [
                ?? command 
            ] %dot.do.6.red
        ]
        do command   

    
    ] 
]  
unless value? '.redlang [
    .redlang: function ['arg [any-type!] ][
        .do/redlang (arg)
    ]
    redlang: :.redlang
    print [{type "help redlang"}]
]

unless value? '.quickrun [
    .quickrun: function [
        'arg [any-type! unset!] 
    ][

        switch type?/word get/any 'arg [
            unset! [
                do https://quickrun.red
                exit
            ]
        ]    

        .do/quickrun (arg)
    ]
    quickrun: :.quickrun
    print [{type "help quickrun"}]
]

unless value? '.quickinstall [
    .quickinstall: function [
        'arg [any-type! unset!] 
        /_debug ; 0.0.0.5.02.6
    ][

        switch type?/word get/any 'arg [
            unset! [
                do https://quickinstall.red
                exit
            ]
        ] 

        ; 0.0.0.5.02.6
        either _debug [
            .do/quickinstall/_debug (arg)
        ][
            .do/quickinstall (arg)
        ]
        
    ]
    quickinstall: :.quickinstall
    print [{type "help quickinstall"}]
]

; dot.do.5.red
unless value? '.install [
    .install: :.quickinstall
]

unless value? 'install [
    install: :.quickinstall
]



unless value? '.codeops [
    .codeops: function [
        'arg [any-type! unset!] 
    ][

        switch type?/word get/any 'arg [
            unset! [
                do https://codeops.red
                exit
            ]
        ] 

        .do/codeops (arg)
    ]
    codeops: :.codeops
    print [{type "help codeops"}]
]

