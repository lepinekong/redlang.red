Red [
    File: "list-files"
    Title: "list-files"
    Html-Proxy: https://
    Description: {
        
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
    'param>folder [word! string! file! path! url! unset!] 
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

    files-list>out: copy []

    switch/default type?/word get/any 'param>folder [

        unset! [
            param>folder: %./
        ]
        word! string! path! file! url! block! [
            param>folder: to-red-file form param>folder
        ]
    ] [
        throw error 'script 'expect-arg param>folder
    ]

    ; / ------------ main -----------
    ; / loop over all files and folders and keep only files
    ; / ------------ main -----------
    local>files-and-folders: read param>folder
    forall local>files-and-folders [
        unless dir? local>file: local>files-and-folders/1 [
            append files-list>out local>file
        ]
    ]
    return files-list>out
    ; // ------------ main -----------
]

.alias .get-list-files [get-list-files]

.list-files: function [
    'param>folder [word! string! file! path! url! unset!] 
    /_build {Build number for developer}
    /silent {don't print message on console}   
    /_debug {debug mode} 
][

    switch/default type?/word get/any 'param>folder [

        unset! [
            param>folder: %./
        ]
        word! string! path! file! url! block! [

            param>folder: form param>folder

        ]
    ] [
        throw error 'script 'expect-arg param>folder
    ]

    local>files: .get-list-files (param>folder)
    forall local>files [
        print local>file: local>files/1
    ]
    
]

.alias .list-files [list-files]