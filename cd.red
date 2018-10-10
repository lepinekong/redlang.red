Red [
    Title: "cd.red"
    Version: [0.0.1 {searching subfolder automatically}]
    Builds: [
        0.0.0.4 {/only for preventing dir list}
        0.0.0.2.8 {searching up if not found TBC}
    ]
]

if not value? '.redlang [
    do https://redlang.red
]
.redlang [search-dir dir-tree]

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

        >builds: [
            0.0.0.4.7 {dir-tree}
        ]

        if build [
            unless silent [
                ?? >builds
            ]
            return >builds
        ]

        >path: :path

        if up [

            thepath: form >path

            if found: search-dir/up (thepath) [
                cd (found)
                dir-tree/expand %./ 0 ; 0.0.0.4.01.2
                dir ; 0.0.0.4.01.2
                return what-dir
            ]
            exit
        ]

        dir-not-found: function [path searchString][
            
            either found: search-dir/folder (searchString) (path) [
                cd (found)
                dir-tree/expand %./ 0 ; 0.0.0.4.01.2
                unless only [ ; 0.0.0.4.01.3
                    dir ; 0.0.0.4.01.2 
                ]           
            ][

            ]
        ]
    
        if paren? get/any 'path [set/any 'path do path] 
        switch/default type?/word get/any 'path [
            unset! [
                dir-tree/expand %./ 0
                path: request-dir
                cd (path)
                dir-tree/expand %./ 0 ; 0.0.0.4.01.2
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
                    dir-tree/expand %./ 0 ; 0.0.0.4.01.2
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
                            dir-tree/expand %./ 0 ; 0.0.0.4.01.2
                            unless only [ ; 0.0.0.4.01.3
                                dir ; 0.0.0.4.01.2 
                            ]  
                            exit
                        ]
                    ]
                ][

                    the-path: to-red-file form >path
                    cd (the-path)
                    dir-tree/expand %./ 0 ; 0.0.0.4.01.2
                    unless only [ ; 0.0.0.4.01.3
                        dir ; 0.0.0.4.01.2 
                    ]  
                    exit
                ]


                if error? try [
                    change-dir to-file path
                    print [{cd} to-file path]
                    dir-tree/expand %./ 0 ; 0.0.0.4.01.2
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
    system/words/..: function [][
        cd ".."
        return what-dir
    ]
    system/words/...: function [][
        cd ".."
        cd ".."
        return what-dir
    ]   
    system/words/....: function [][
        cd ".."
        cd ".."
        cd ".."        
        return what-dir
    ]      
    ; system/words/.1: function [][
    ;     cd ".."
    ;     return what-dir
    ; ]
    ; system/words/.2: function [][
    ;     cd ../..
    ;     return what-dir
    ; ]  
    ; system/words/.3: function [][
    ;     cd ../../..
    ;     return what-dir
    ; ]  
    if not value? '.c [
        system/words/.c: function [][
            cd %/c/
            return what-dir
        ]           
    ]
    if not value? '.d [
        system/words/.d: function [][
            cd %/d/
            return what-dir
        ]           
    ] 

]

