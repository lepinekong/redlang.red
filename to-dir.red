Red [
    Title: "to-dir.red"
]

.to-dir:  function[.dir [word! string! file! url! block! unset!] ][

	{

        #### Example:
        - [x] [0]. to-dir %/c/test/ -> %/c/test/
        - [x] [1]. to-dir %/c/test -> %/c/test/
        - [X] [2]. to-dir c:\test -> %/c/test/

    }

    switch/default type?/word .dir [
        unset! [
            print {TODO:}
        ]
        file! [
            dir: :.dir
            if not dir? dir [
                append dir to-string "/"
                to-red-file dir            
            ]
            dir
        ]
        word! string! url! [
            dir: to-red-file to-string :.dir
            replace/all dir "//" "/"         
            to-dir (dir)
        ]
        block! [
            dir: .dir
            joined-dir: copy ""
            forall dir [
                append joined-dir rejoin [dir/1 "/"]
            ]
            repeat i 2 [replace/all joined-dir "//" "/"]
            to-red-file joined-dir
        ]
    ] [
        throw error 'script 'expect-arg varName
    ]
]

to-dir: :.to-dir