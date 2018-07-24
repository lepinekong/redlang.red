Red [
    Title: "copy-file.red"
    Builds: [
        0.0.0.1 {Initial build with file versioning or /force}
    ]
    Iterations: [
        0.0.0.1.8 {list-files: get-list-files target-folder}
    ]    
]

copy-file: function [>source >target /force][

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
                next-file: rejoin [short-filename  "."  i  extension]                
            ]

            do https://redlang.red/file-path
            short-filename: .get-short-filename >target
            extension: .get-file-extension >target
            target-folder: pick (split-path >target) 1

            next-file: >target
            while [exists? next-file][
                next-file: rejoin [target-folder get-next-file] 
            ]

            do https://redlang.red/list-files
            list-files: get-list-files target-folder
            ?? list-files
            
            write next-file read >source
            print [next-file "created."]
        ][
            write >target read >source
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