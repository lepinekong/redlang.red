Red [
    Title: "search-dir.red"
]

do https://redlang.red/do-events

search-dir: function [
    /folder {startup folder} '>folder 
    '>searchString
][
    ; ?? >folder
    ; ?? >searchString
    ; ask "13"
    
    either folder [
        .folder: form >folder
    ][
        .folder: what-dir
    ]
    .searchString: form >searchString

    .folder: to-red-file .folder
    ; ?? .folder
    ; ask "20"
    ; files: read .folder
    ; ask "22"

    dirs-found: []
    if error? try [
        files: read .folder
        ; ?? files
        ; ask "26"
    ][
        files: copy []
    ]

    foreach file files [
        file: rejoin [.folder file]
        .do-events/no-wait

        if dir? file [
            stringFile: (form file)
            either find stringFile .searchString [
                append dirs-found file
            ][
                search-dir/folder (file) (.searchString) ; BUG was here, must switch
            ]
        ]
    ]
    return pick dirs-found 1
]

; do https://redlang.red/cd

; cd C:\MyTutorials
; test: search-dir %./ Getting-Started
; ?? test


