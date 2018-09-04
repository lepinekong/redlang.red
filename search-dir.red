Red [
    Title: "search-dir.red"
]

if not value? '.redlang [
    do http://redlang.red
]
.redlang [block-to-string]

try [do https://redlang.red/do-events]

do http://redlang.red/do-trace

.search-dir: function [
    '>searchString [any-type!] {partial folder name} 
    /folder {startup folder} '>folder     
    /all {return all folders found in a block}
    /build
    /silent
][
    >build: 0.0.0.2.22.1
    if build [

        unless silent [
            print >build
        ] 
        return >build
    ]

    either folder [
        .folder: form :>folder        
    ][
        .folder: what-dir
    ]

    .searchString: form >searchString

    .folder: to-red-file .folder    
    if not dir? .folder [
        .folder: rejoin [.folder %/]
    ]

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
                found?: .search-dir/folder (.searchString) (fold)  ; BUG was here, must switch
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

search-dir: function [  
    '>folder [file! word! path! unset! string! paren! url!] 
    /folder >parent-folder [file! word! path! unset! string! paren! url!]  
    /up   
    /build
][
    if build [
        return .search-dir/build
    ]

    if not folder [
        >parent-folder: %./
    ]  

    .folder: :>folder

    unless up [

        folder>: .search-dir/folder (.folder) (>parent-folder)
        return folder>
    ]

    sub-parent-folders: split (form clean-path to-red-file (>parent-folder)) "/"
    sub-folders: reverse sub-parent-folders
    found: find sub-folders (form .folder)
    result: reverse found
    output: to-red-file block-to-string result "/"    
    return output
]
