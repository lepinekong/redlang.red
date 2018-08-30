Red [
    Title: "cd.7.red"
]

do https://redlang.red/do-trace
do https://redlang.red/search-dir

if not value? 'syscd [
    syscd: :cd
    cd: func [
        "Change directory (shell shortcut function)." 
        [catch] 
        'path [file! word! path! unset! string! paren! url!] "Accepts %file, :variables and just words (as dirs)"
        /search
    ][
        >path: :path

        dir-not-found: function [path searchString][
            print rejoin ["Path" { "} searchString {" } "not found, searching partial name..."]

            if error? try [
                files: read path
            ][
                files: copy []
            ]
            
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
                either (length? dirs-found) = 1 [
                    n: 1
                ][
                    n: to-integer ask "Select number, 0 for none, else to exit: "
                ]
                
                either (n > 0) [
                    chosen-dir: dirs-found/:n
                    cd (chosen-dir)
                    return chosen-dir
                    exit ; doesn't seem to exit, loop continues ?!!!
                ][
                    foreach file all-dirs [
                        dir-not-found file searchString
                    ]
                ]

            ][
                either search [
                    print [>path {not found. searching...}]
                    forall all-dirs [
                        root: all-dirs/1
                            dir-not-found root searchString
                    ]

                ][
                    print [>path {not found. Use /search to search folder}]
                ]
            ]

        ]
    
        if paren? get/any 'path [set/any 'path do path] 
        switch/default type?/word get/any 'path [
            unset! [
                print what-dir
                path: request-dir
                cd (path)
            ] 

            string! file! url! [ 
                searchString: form path
                path: to-file searchString
                
                if error? try [
                    change-dir to-file path
                    print [{cd} to-file path]
                ][
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

                    ;change-dir path ; changed in cd.3.red
                    if error? try [
                        change-dir to-file path
                        print [{cd} to-file path]
                    ][
                        searchString: form path                      
                        dir-not-found %. searchString
                    ]                    
                ; ]
                if exists? %autoload.red [
                    do %autoload.red
                ]
                if exists? %.red [
                    do %.red
                ]                
            ]
        ] [
            throw error 'script 'expect-arg reduce ['cd 'path type? get/any 'path]
        ]
        what-dir  
    ]    
]
