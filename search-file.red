Red [
    Title: "search-file.red"
]

do https://redlang.red/do-events

search-file: function [
    'path 
    'searchString
][

    path: form path
    searchString: form searchString
    path: to-red-file path
    files-found: []
    if error? try [
        files: read path
    ][
        files: copy []
    ]

    foreach file files [
        file: rejoin [path file]
        .do-events/no-wait

        either dir? file [
            search-file (file) (searchString)
        ][
            stringFile: (form file)
            if find stringFile searchString [
                append files-found file
            ]
        ]
    ]
    return pick files-found 1
]

; do https://redlang.red/cd

; test: search-file c:\windows\ csc.exe
; ?? test
; ;test: %/c/windows/Microsoft.NET/Framework/v2.0.50727/csc.exe

