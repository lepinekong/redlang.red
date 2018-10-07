Red [
    Title: "make-dir.red"
    Url: 
    Builds: [
        0.0.0.2.2 {md alias}
    ]    
]

if not value? '.redlang [
    do https://redlang.red
]

.redlang [cd alias]

if not value? '.sysmake-dir [
    .sysmake-dir: :make-dir
]

.make-dir:  function [
    'param>folder [word! string! file! path! url! paren! unset!]
    /no-deep {don't create subdirectories}
    /no-create /not-create {same as no-deep}
    /_build {Build number for developer}
    /silent {don't print message on console}   
    /_debug {debug mode} 
][

    >builds: 0.0.0.2.1.2

    if _build [
        unless silent [
            print >builds
        ]
        return >builds
    ]

    switch/default type?/word get/any 'param>folder [
        unset! [
            print {
Description:
    Create a folder. 
Optional:
    /no-deep don't create subdirectories
    /no-cd don't change directory        
            }
        ]
        word! string! file! path! url! paren! [

            local>folder: form :param>folder
            local>command: rejoin [
                ".sysmake-dir" 
                if ((not no-deep) or (no-create) or (not-create)) ["/deep"]
                "%" local>folder
            ]
            do local>command
                if _debug [print local>command]  
            unless no-cd [
                cd (local>folder)
            ]          
            
        ]
    ] [
        throw error 'script 'expect-arg param>folder
    ]
]
make-dir: :.make-dir
.alias .make-dir [
    md
    .md
    create-dir
    .create-dir
    create-directory
    .create-directory
]


