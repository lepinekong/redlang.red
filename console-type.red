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

.alias .console-type? [console-type?]
