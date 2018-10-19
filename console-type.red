Red [
    File: "console-type?"
    Title: "console-type?"
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

.console-type?: function [
    'param>options [word! string! file! url! block! unset!] 
    /_build {Build number for developer}
    /silent {don't print message on console}   
    /_debug {debug mode} 
][

    >builds: [
        0.0.0.01.1 {Initial version}
    ]

    if _build [
        unless silent [
            print >builds
        ]
        return >builds
    ]

    switch/default type?/word get/any 'param>options [
        unset! [
            either (system/console = none) [ 
                ; for compiled version (no console)
                return 'none
            ][ 
                either system/console/gui? [
                    ; for interpreted version with gui console
                    return 'gui
                ][
                    ; for interpreted version with non-gui console (vscode)
                    return 'cli
                ]
            ] 
        ]
        word! string! file! url! block! [
            param>options: form param>options
            print {TODO:}
        ]
    ] [
        throw error 'script 'expect-arg param>options
    ]
]

.alias .console-type? [console-type?]
