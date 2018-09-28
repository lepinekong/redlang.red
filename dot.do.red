Red [
    Title: "do.red"
    SemVer: [1.0.0 {Alpha version}]
    Builds: [
        0.0.0.3.3 {/quickrun}
    ]
]
if not value? '.do [

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
        /silent { [DEPRECATED] Don't print command}
        /_debug {debug mode for developer only}
        /_build

    ][
        >build: [0.0.0.4.3 {
            - /silent deprecated
            - /_build added
        }]

        if _build [
            print >build
            return >build
            exit
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



    
    ] 
]  
.redlang: function ['arg [any-type!] ][
    .do/redlang (arg)
]
redlang: :.redlang
print [{type "help redlang"}]

.quickrun: function [
    'arg [any-type! unset!] 
][

    switch type?/word get/any 'arg [
        unset! [
            do https://quickrun.red
            exit
        ]
    ]    
    ; either (find arg "/") [
    ;     splitted-arg: split arg "/"
    ;     arg: splitted-arg/1
    ; ][

    ; ]

    .do/quickrun (arg)
]
quickrun: :.quickrun
print [{type "help quickrun"}]


