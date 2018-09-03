Red [
    Title: "cd.red"
    Version: [0.0.1 {searching subfolder automatically}]
    Builds: [
        0.0.0.2.8 {searching up if not found TBC}
    ]
]

do https://redlang.red/search-dir

if not value? 'syscd [
    syscd: :cd
    .cd: func [
        "Change directory (shell shortcut function)." 
        [catch] 
        'path [file! word! path! unset! string! paren! url!] "Accepts %file, :variables and just words (as dirs)"
        /search
        /build 
        /no-autoexec {don't autoexecute %.red and %autoload.red}
    ][

        search: true

        >build: 0.0.0.2.6

        if build [
            print >build
            return >build
        ]

        >path: :path

        dir-not-found: function [path searchString][
            
            either found: search-dir/folder (searchString) (path) [
                cd (found)
            ][

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

                if error? try [
                    if value? to-word >path [ 
                        the-path: (get in system/words >path)
                        if not logic? the-path [
                            cd (the-path)
                            what-dir
                            exit
                        ]
                    ]
                ][

                    the-path: to-red-file form >path
                    cd (the-path)
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
                
                unless no-autoexec [
                    if exists? %autoload.red [
                        do %autoload.red
                    ]
                    if exists? %.red [
                        do %.red
                    ] 
                ]
            ]
        ] [
            throw error 'script 'expect-arg reduce ['cd 'path type? get/any 'path]
        ]
        what-dir  
    ]   
    system/words/cd: :.cd 
]

