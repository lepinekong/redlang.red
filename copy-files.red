Red [
    Title: "copy-file.red"
    Iterations: [
        0.0.0.1.2 {Protecting existing files}
        0.0.0.1.1 {Initial build}
    ]    
]

copy-file: function [>source >target /force][

    either force [
        write >target read >source
    ][
        either exists? >target [

            print [>target "already exists."]

            do https://redlang.red/file-path
            short-filename: .get-short-filename >target
            ?? short-filename
            ask "pause"
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