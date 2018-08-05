Red [
    Title: "search-dir.red"
]

do https://redlang.red/do-events

search-dir: function [
    'path 
    'searchString
][

    path: form path
    searchString: form searchString
    path: to-red-file path
    dirs-found: []
    if error? try [
        files: read path
    ][
        files: copy []
    ]

    foreach file files [
        file: rejoin [path file]
        .do-events/no-wait

        if dir? file [
            stringFile: (form file)
            either find stringFile searchString [
                append dirs-found file
            ][
                search-dir (file) (searchString)
            ]
        ]
    ]
    return pick dirs-found 1
]

; do https://redlang.red/cd

; cd C:\MyTutorials
; test: search-dir %./ Getting-Started
; ?? test


