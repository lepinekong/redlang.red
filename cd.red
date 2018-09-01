Red [
    Title: "cd.red"
    Version: [0.0.0.2.2 {searching subfolder automatically}]
]

;do https://redlang.red/do-trace
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

        >version: 0.0.0.2.2

        if version [
            print >version
            return >version
        ]

        >path: :path

        dir-not-found: function [path searchString][
            
            if not none? found: search-dir/folder (searchString) (path) [
                cd (found)
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
