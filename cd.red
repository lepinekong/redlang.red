Red [
    Title: "cd.red"
]

if not value? 'syscd [
    syscd: :cd
    cd: func [
        "Change directory (shell shortcut function)." 
        [catch] 
        'path [file! word! path! unset! string! paren! url!] "Accepts %file, :variables and just words (as dirs)"
    ][
        dir-not-found: function [path searchString][
            print rejoin ["Path" { "} searchString {" } "not found, searching partial name..."]
            files: read path
            dirs-found: copy []
            all-dirs: copy []
            foreach file files [
                if dir? file [
                    if find (to-string file) searchString [
                        print rejoin [searchString " found in " file]
                        append dirs-found file
                    ]
                    append all-dirs file
                ]
            ]

            either (length? dirs-found) > 0 [
                probe dirs-found   
                n: to-integer ask "Which one do you choose? 0 for none, else to exit: "
                either (n > 0) [
                    chosen-dir: dirs-found/:n
                    cd (chosen-dir)
                ][
                    either (n = 0) [
                        foreach file all-dirs [
                            dir-not-found file searchString
                        ]
                    ][
                        exit
                    ]
                ]

            ][

            ]


        ]
    
        if paren? get/any 'path [set/any 'path do path] 
        switch/default type?/word get/any 'path [
            unset! [print what-dir] 

            string! file! url! [ 
                ;path: to-string path
                searchString: (to-string path)
                path: to-file searchString
                if error? try [ change-dir to-file path][
                    dir-not-found %. searchString
                ]
                
            ] 
            word! path! [

                ; either value? :path [
                ;     body: body-of get :domain
                ;     subsystem-path: body/subsystem-path/1
                ;     system-path: body/system-path/1
                ;     root-path: body/root-path/1  
                ;     ;%/C/rebol/system/.activities/myTutorials
                ;     filepath: to-file (rejoin [root-path system-path subsystem-path]) 
                ;     change-dir filepath

                ; ][
                    change-dir path
                ; ]
                if exists? %autoload.red [
                    do %autoload.red
                    ;print "autoload.red executed"
                ]
                if exists? %.red [
                    do %.red
                    ;print ".red executed"
                ]                
            ]
        ] [
            throw error 'script 'expect-arg reduce ['cd 'path type? get/any 'path]
        ]
        what-dir  
    ]    
]