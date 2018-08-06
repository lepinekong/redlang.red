Red [
    Title: "search-dir.red"
    Builds: [
        0.0.0.1 {Initial Build
            - search partial folder name
            - optional startup folder or default current folder
        }
    ]
    Iterations: [
        0.0.0.1.7 {/all option for returning all folders found}
    ]
]

;do https://redlang.red/do-events

search-dir: function [
    /folder {startup folder} '>folder 
    '>searchString {partial folder name}
    /all {return all folders found in a block}
][
    
    either folder [
        .folder: form >folder
    ][
        .folder: what-dir
    ]
    .searchString: form >searchString

    .folder: to-red-file .folder

    dirs-found: []
    if error? try [
        files: read .folder
    ][
        files: copy []
    ]

    folders: copy []
    forall files [
        if dir? fold: files/1 [
            stringFile: (form fold)
            if find stringFile .searchString [
                append folders fold
            ]   
        ]
    ]
    foreach file folders [
        file: rejoin [.folder file]
        ;.do-events/no-wait

        if dir? file [
            stringFile: (form file)
            either find stringFile .searchString [
                append dirs-found file
            ][
                search-dir/folder (file) (.searchString) ; BUG was here, must switch
            ]
        ]
    ]
    either all [
        return dirs-found
    ][
        return pick dirs-found 1
    ]

]

; do https://redlang.red/cd

; cd C:\MyTutorials
; test: search-dir %./ Getting-Started
; ?? test


