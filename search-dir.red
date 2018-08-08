Red [
    Title: "search-dir.red"
    Builds: [
        0.0.0.1.14 {Initial Build
            - search partial folder name
            - optional startup folder or default current folder
        }
    ]

]

try [do https://redlang.red/do-events]

do http://redlang.red/do-trace

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
        fold: files/1

    
        if dir? fold: files/1 [
            append folders fold
            stringFile: (form fold)
            if find stringFile .searchString [
                dir-found: rejoin [.folder fold]
                if not all [
                    return dir-found 
                ]
                append dirs-found dir-found            
            ]   
        ]
    ]

    foreach fold folders [

        fold: rejoin [.folder fold]
        if value? '.do-events [.do-events/no-wait] ; release processing to OS

        if dir? fold [
            stringFile: (form fold)
            either find stringFile .searchString [               
                if not find dirs-found fold [
                    append dirs-found fold  
                ]

                
            ][
                found?: search-dir/folder (fold) (.searchString) ; BUG was here, must switch
                if not none? found? [
                    return found?
                ]
            ]
        ]
    ]
    either all [
        return dirs-found
    ][
        return pick dirs-found 1
    ]

]


