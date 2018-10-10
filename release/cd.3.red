Red [
    Title: "cd.red"
    Version: [0.0.1 {searching subfolder automatically}]
    Builds: [
        0.0.0.4 {/only for preventing dir list}
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
        /only {do not list folders}
        /search
        /up
        /build 
        /no-autoexec {don't autoexecute %.red and %autoload.red}
        /silent
    ][

        search: true

        >build: 0.0.0.2.13

        if build [
            unless silent [
                print >build
            ]
            return >build
        ]

        >path: :path

        if up [

            thepath: form >path

            if found: search-dir/up (thepath) [
                cd (found)
                print what-dir ; 0.0.0.4.01.2
                dir ; 0.0.0.4.01.2
                return what-dir
            ]
            exit
        ]

        dir-not-found: function [path searchString][
            
            either found: search-dir/folder (searchString) (path) [
                cd (found)
                print what-dir ; 0.0.0.4.01.2
                unless only [ ; 0.0.0.4.01.3
                    dir ; 0.0.0.4.01.2 
                ]           
            ][

            ]
        ]
    
        if paren? get/any 'path [set/any 'path do path] 
        switch/default type?/word get/any 'path [
            unset! [
                print what-dir
                path: request-dir
                cd (path)
                print what-dir ; 0.0.0.4.01.2
                unless only [ ; 0.0.0.4.01.3
                    dir ; 0.0.0.4.01.2 
                ]        
            ] 

            string! file! url! [ 
                searchString: form path
                path: to-file searchString
                
                if error? try [
                    change-dir to-file path
                    print [{cd} to-file path]
                    print what-dir ; 0.0.0.4.01.2
                    unless only [ ; 0.0.0.4.01.3
                        dir ; 0.0.0.4.01.2 
                    ]                    
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
                            print what-dir ; 0.0.0.4.01.2
                            unless only [ ; 0.0.0.4.01.3
                                dir ; 0.0.0.4.01.2 
                            ]  
                            exit
                        ]
                    ]
                ][

                    the-path: to-red-file form >path
                    cd (the-path)
                    print what-dir ; 0.0.0.4.01.2
                    unless only [ ; 0.0.0.4.01.3
                        dir ; 0.0.0.4.01.2 
                    ]  
                    exit
                ]


                if error? try [
                    change-dir to-file path
                    print [{cd} to-file path]
                    print what-dir ; 0.0.0.4.01.2
                    unless only [ ; 0.0.0.4.01.3
                        dir ; 0.0.0.4.01.2 
                    ]                    
                ][
                    searchString: form path                      
                    dir-not-found %. searchString
                ]                    
                
                ; unless no-autoexec [
                ;     if exists? %autoload.red [
                ;         do %autoload.red
                ;     ]
                ;     if exists? %.red [
                ;         do %.red
                ;     ] 
                ; ]
            ]
        ] [
            throw error 'script 'expect-arg reduce ['cd 'path type? get/any 'path]
        ]
        what-dir  
    ]   
    system/words/cd: :.cd 
]

