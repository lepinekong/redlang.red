; / ------------------- file header ------------------
Red [
    Title: "do.red"
    SemVer: [1.0.0 {Alpha version}]
    Builds: [
        0.0.0.6.03.2 {optimization}
        0.0.0.5.3.1 {autoexec quickinstall except load-only}
        0.0.0.5.02.5 {alias .install/install for quickinstall}
        0.0.0.5.2.2 {performance optimization}
        0.0.0.5.2 {/codeops}
        0.0.0.5.1 {/quickinstall}
        0.0.0.3.3 {/quickrun}
    ]
]
; ------------------- file header ------------------ /

; / -------------------.do ------------------
unless value? '.do [

    .do: function [

        {.do/redlang allows you to load multiples redlang libraries with a shortcut syntax.} 
        'value [any-type! unset!] 
        /load-only "only load quickinstall component, do not auto-execute it for example vscode"
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
        /local static>loaded-urls

    ][
        >builds: [
            0.0.0.6.03.2 {optimization}
            0.0.0.5.3.1 {autoexec quickinstall except load-only}
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

        silent: true

        if _debug [
            do https://redlang.red/do-trace ; 0.0.0.5.03.1
        ] 

        ; 0.0.0.6.03.2
        static>loaded-urls: []
        if _debug [
            do-trace 50 [
                ?? static>loaded-urls
            ] %02.dot.do.function.red
            
        ]               

        value: :value

        if redlang [

            .refinement: "redlang"
            .domain: rejoin [.refinement ".red"]

            either block? value [

                new-value: copy value

                forall new-value [

                    command: copy []
                    main-command: copy rejoin [".do/" .refinement]

                    const>refinements: [ ; 0.0.0.6.03.1
                        expand args next silent _debug
                    ]                    
                    forall const>refinements [
                        word>refinement: const>refinements/1
                        val>refinement: (get word>refinement)
                        if val>refinement [
                            main-command: rejoin [main-command "/" form word>refinement]
                        ]
                    ]                    
                    ; if expand [
                    ;     main-command: rejoin [main-command "/expand"]
                    ; ]
                    ; if args [
                    ;     main-command: rejoin [main-command "/args"]
                    ; ]
                    ; if next[
                    ;     main-command: rejoin [main-command "/next"]
                    ; ]
                    ; if silent[
                    ;     main-command: rejoin [main-command "/silent"]
                    ; ]
                    ; if _debug[
                    ;     main-command: rejoin [main-command "/_debug"]
                    ; ] 

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

                    const>refinements: [ ; 0.0.0.6.03.1
                        expand args next silent _debug
                    ]                    
                    forall const>refinements [
                        word>refinement: const>refinements/1
                        val>refinement: (get word>refinement)
                        if val>refinement [
                            main-command: rejoin [main-command "/" form word>refinement]
                        ]
                    ]
                    ; if expand [
                    ;     main-command: rejoin [main-command "/expand"]
                    ; ]
                    ; if args [
                    ;     main-command: rejoin [main-command "/args"]
                    ; ]
                    ; if next[
                    ;     main-command: rejoin [main-command "/next"]
                    ; ]
                    ; if silent[
                    ;     main-command: rejoin [main-command "/silent"]
                    ; ]
                    ; if _debug[
                    ;     main-command: rejoin [main-command "/_debug"]
                    ; ] 

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

                    const>refinements: [ ; 0.0.0.6.03.1
                        load-only expand args next silent _debug
                    ]                    
                    forall const>refinements [
                        word>refinement: const>refinements/1
                        val>refinement: (get word>refinement)
                        if val>refinement [
                            main-command: rejoin [main-command "/" form word>refinement]
                        ]
                    ]                    

                    ;0.0.0.5.03.8
                    ; if load-only [
                    ;     main-command: rejoin [main-command "/load-only"]
                    ; ]
                    
                    ; if expand [
                    ;     main-command: rejoin [main-command "/expand"]
                    ; ]
                    ; if args [
                    ;     main-command: rejoin [main-command "/args"]
                    ; ]
                    ; if next[
                    ;     main-command: rejoin [main-command "/next"]
                    ; ]
                    ; if silent[
                    ;     main-command: rejoin [main-command "/silent"]
                    ; ]
                    ; if _debug[
                    ;     main-command: rejoin [main-command "/_debug"]
                    ; ] 

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

                    ; !!! 0.0.0.5.03.1
                    value: copy []      

                    either find url-string "https" [
                        parse url-string [
                            thru "https://" start: (insert start rejoin [.domain "/"])
                        ]
                        ; !!! 0.0.0.5.03.1
                        ;value: to-url url-string
                        append value to-url url-string
                    ][
                        ; !!! 0.0.0.5.03.1
                        ;value: to-url rejoin ["https://" .domain "/" url-string]
                        append value to-url rejoin ["https://" .domain "/" url-string]
                    ]
                    ; !!! 0.0.0.5.03.1
                    ;append value compose/deep [unless load-only [(to-word rejoin [".install-" url-string])] ] 

                    ; !!! 0.0.0.5.03.2
                    unless load-only [
                        ; !!! 0.0.0.5.03.3
                        either find url-string "/" [
                            keyword: last split url-string "/"

                            ; !!! 0.0.0.5.03.4
                            replace keyword "install-" ""
                            
                            append value to-word rejoin [".install-" keyword]
                        ][
                            append value to-word rejoin [".install-" url-string]
                        ]
                        
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

                    const>refinements: [ ; 0.0.0.6.03.1
                        expand args next silent _debug
                    ]                    
                    forall const>refinements [
                        word>refinement: const>refinements/1
                        val>refinement: (get word>refinement)
                        if val>refinement [
                            main-command: rejoin [main-command "/" form word>refinement]
                        ]
                    ]                     
                    ; if expand [
                    ;     main-command: rejoin [main-command "/expand"]
                    ; ]
                    ; if args [
                    ;     main-command: rejoin [main-command "/args"]
                    ; ]
                    ; if next[
                    ;     main-command: rejoin [main-command "/next"]
                    ; ]
                    ; if silent[
                    ;     main-command: rejoin [main-command "/silent"]
                    ; ]
                    ; if _debug[
                    ;     main-command: rejoin [main-command "/_debug"]
                    ; ] 

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

        const>refinements: [ ; 0.0.0.6.03.1
            expand args next
        ]                    
        forall const>refinements [
            word>refinement: const>refinements/1
            val>refinement: (get word>refinement)
            if val>refinement [
                main-command: rejoin [main-command "/" form word>refinement]
            ]
        ]        
        
        ; if expand [
        ;     main-command: rejoin [main-command "/expand"]
        ; ]
        ; if args [
        ;     main-command: rejoin [main-command "/args"]
        ; ]
        ; if next[
        ;     main-command: rejoin [main-command "/next"]
        ; ]

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

        ; 0.0.0.6.03.2
        either find static>loaded-urls value [
            if _debug [
                do-trace 46 [
                    print [value "already loaded"]
                ] %06.default.case.red
                
            ]
        ][
            do command  
            append static>loaded-urls value
        ]        

    
    ] 
]
; -------------------.do ------------------ /
; / ------------------- alias redlang ------------------
unless value? '.redlang [
    .redlang: function [
        'arg [any-type!] 
        /_debug
    ][
        either _debug [
            .do/redlang/_debug (arg)
        ][
            .do/redlang (arg)
        ]
        
    ]
    redlang: :.redlang
    print [{type "help redlang"}]
]
; ------------------- alias redlang ------------------ /
; / ------------------- alias quickrun ------------------
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
; ------------------- alias quickrun ------------------ /
; / ------------------- alias quickinstall ------------------
unless value? '.quickinstall [
    .quickinstall: function [
        'arg [any-type! unset!] 
        /load-only "only load quickinstall component, do not auto-execute it for example vscode"
        /_debug ; !!! 0.0.0.5.03.1
    ][

        ;!!!!! 0.0.0.5.03.9
        ; switch type?/word get/any 'arg [
        ;     unset! [
        ;         do https://quickinstall.red
        ;         exit
        ;     ]
        ; ] 

        ; 0.0.0.5.03.8
        if _debug [
            do https://redlang.red/do-trace
        ] 

        ; !!! 0.0.0.5.03.6
        either load-only [
            either _debug [
                .do/quickinstall/load-only/_debug (arg)
            ][
                .do/quickinstall/load-only (arg)
            ]
        ][
            either _debug [
                .do/quickinstall/_debug (arg)
            ][
                .do/quickinstall (arg)
            ]
        ]                 
    ]
    quickinstall: :.quickinstall
    print [{type "help quickinstall"}]
]

; dot.do.5.red
; unless value? '.install [
;     .install: :.quickinstall
; ]

; unless value? 'install [
;     install: :.quickinstall
; ]

;!!!!! 0.0.0.5.03.9
unless value? '.install [
    do https://quickinstall.red
]
; ------------------- alias quickinstall ------------------ /

; / ------------------- alias codeops ------------------
unless value? '.codeops [
    .codeops: function [
        'arg [any-type! unset!] 
        /_build
    ][

        if _build [
            >builds: [
                0.0.0.7.1.2 {if error? try}
            ]
        ]
        switch type?/word get/any 'arg [
            unset! [
                do https://codeops.red
                exit
            ]
        ] 

        if error? try [
            .do/codeops (arg)
        ][
            print ["error executing: .do/codeops " arg] ; 0.0.0.7.01.2
        ]
        
    ]
    codeops: :.codeops
    print [{type "help codeops"}]
]
; ------------------- alias codeops ------------------ /

