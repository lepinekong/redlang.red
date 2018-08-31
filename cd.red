Red [
    Title: "cd.red"
    Version: [0.0.1.17 {support of variable without using ()}]
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
        /version 
    ][
        search: true

        >version: 0.0.1.17

        if version [
            print >version
            return >version
        ]

        >path: :path

        dir-not-found: function [path searchString][
            ;print rejoin ["Path" { "} searchString {" } "not found, searching partial name..."]

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
                        folder-found: rejoin [path file]
                        print rejoin [searchString " found in " folder-found]
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
                    chosen-dir: to-red-file rejoin [path dirs-found/:n]
                    change-dir (chosen-dir)
                    return chosen-dir
                    exit ; doesn't seem to exit, loop continues ?!!!
                ][
                    foreach file all-dirs [
                        dir-not-found file searchString
                    ]
                ]

            ][
                either search [
                    ;print [>path {not found. searching...}]
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

                if value? to-word >path [                
                    cd (get in system/words >path)
                    what-dir
                    exit
                ]

                if error? try [
                    change-dir to-file path
                    print [{cd} to-file path]
                ][
                    searchString: form path                      
                    dir-not-found %. searchString
                ]                    
                
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
