Red [
    File: "join"
    Title: "join"
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
.redlang [alias block-to-string]

.join: function [
    param>block [block!] 
    /spacer param>spacer
    /space
    /newline
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

    unless spacer [
        either newline [
            param>spacer: newline
        ][
            param>spacer: " "
        ]
        
    ]

    .block-to-string/block/delimiter (param>block) (param>spacer)
]

.alias .join [join]
