Red [
    Title: "copy-file.red"
    Builds: [
        0.0.0.1 {Initial build with file versioning or /force and checksum}
    ]
    Iterations: [
        0.0.0.1.10 {Add checksum}
        0.0.0.1.9 {FIXED BUG}
        0.0.0.1.8 {list-files: get-list-files target-folder}
        0.0.0.1.7 {Fixed don't use COPY for static counter !}
        0.0.0.1.6 {Fixed with target-folder: pick (split-path >target) 1
        BUG: infinite loop ?}
        0.0.0.1.5 {Fixed by deleting + in rejoin
        BUG: forgot target folder
        }
        0.0.0.1.4 {Fixed with () to [] for while condition 
        Bug: 
*** Script Error: + does not allow file! for its value1 argument
*** Where: +
*** Stack: copy-file rejoin empty?
        }
        0.0.0.1.3 {get-next-file: function [/local counter][
        BUG: while does not allow logic! for its cond argument
        }       
        0.0.0.1.2 {Protecting existing files}
        0.0.0.1.1 {Initial build}
    ]    
]

compare-checksum: function [>file1 >file2][
    file1-content: read >file1
    checksum-file1: checksum file1-content 'SHA256
    file2-content: read >file2
    checksum-file2: checksum file2-content 'SHA256 
    return (checksum-file1 = checksum-file2)  
]

copy-file: function [>source >target /force /no-checksum][

    either force [
        write >target read >source
    ][
        either exists? >target [

            print [>target "already exists."]

            get-next-file: function [/local counter][
                counter: []
                if empty? counter [
                    append counter 0
                ]
                counter/1: counter/1 + 1
                i: counter/1
                next-file: rejoin [short-filename-wo-extension "."  i  extension]                
            ]

            do https://redlang.red/file-path
            short-filename: .get-short-filename >target
            short-filename-wo-extension: get-short-filename-without-extension >target
            extension: .get-file-extension >target
            target-folder: pick (split-path >target) 1

            next-file: >target
            while [exists? next-file][
                previous-file: next-file
                next-file: rejoin [target-folder get-next-file] 
            ]

            do https://redlang.red/list-files
            list-files: get-list-files target-folder
            ?? list-files

            unless no-checksum [

                ; source-content: read >source
                ; checksum-source: checksum source-content 'SHA256
                ; previous-file-content: read previous-file
                ; checksum-previous: checksum previous-file-content 'SHA256

                ;either checksum-previous <> checksum-source [
                either false = compare-checksum >source previous-file [    
                    write next-file read >source
                    print [next-file "created."]
                    return true
                ][
                    print [previous-file "is up to date."]
                    return false
                ]
            ]
            ; no-checksum
            write next-file read >source
            print [next-file "created."]
            return true
        ][
            write >target read >source
            print [>target "created."]
        ]
    ]

]

copy-files: function[>list][

    list: >list
    forall list [
        files: list/1
        source: files/1
        target: files/2
        copy-file source target   
    ]
]

; i: 4

; list: compose/deep [

;     [
;         %../index.html 
;         %../../../.github/tests/index.html
;     ]
;     [
;         %../index.html
;         (rejoin [%../../../.github/tests/index "." i "." "html"])
;     ]

;     [
;         %../authoring.html
;         %../../../.github/tests/authoring.html
;     ]

;     [
;         (rejoin [%../lib "." i "." "red"])
;         (rejoin [%../../../.github/tests/lib "." "red"])
;     ]

;     [
;         (rejoin [%../lib "." i "." "red"])
;         (rejoin [%../../../.github/tests/lib "." i "." "red"])
;     ]
; ]

; copy-files list