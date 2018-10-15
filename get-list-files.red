Red [
    File: "get-list-files"
    Title: "get-list-files"
    Html-Proxy: https://https://redlang.red/get-list-files.html
    Description: {
        list files except folders
    }
    Features: [
        
    ]
    Builds:[
        0.0.0.1.1.1
    ]
    TODO: [
        1 {allow todo: 1.}
        2 {...}
    ]
]

unless value? '.redlang [
    do https://redlang.red
]
.redlang [alias]

.get-list-files: function [
    'param>extension [word! string! file! url! block! unset!] 
    /_build {Build number for developer}
    /silent {don't print message on console}   
    /_debug {debug mode} 
][

    >builds: 0.0.0.0.1.1

    if _build [
        unless silent [
            print >builds
        ]
        return >builds
    ]

    list-files>out: copy []
    files-and-folders: read %./

    switch/default type?/word get/any 'param>extension [
        unset! [
            
            forall files-and-folders [
                unless dir? file: files-and-folders/1 [
                    append list-files>out file
                ]
            ]

        ]
        word! string! file! block! [
            file-extension: to-red-file rejoin [unless ((first form param>extension) = ".") ["."] form param>extension]
            forall files-and-folders [
                unless dir? file: files-and-folders/1 [
                    ext: suffix? file
                    if  ext = file-extension [
                        append list-files>out file
                    ]
                ]
            ]
        ]
    ] [
        throw error 'script 'expect-arg param>extension
    ]

    return sort/reverse list-files>out
]

.alias .get-list-files [get-list-files]

do [test: get-list-files]
?? test
