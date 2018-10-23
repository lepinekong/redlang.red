Red [
    File: "xcopy"
    Title: "xcopy"
    Html-Proxy: https://
    Description: {
        call xcopy
    }
    Links: [
        https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/xcopy
    ]
    Features: [
        1 {logging}
    ]
    Builds:[
        0.0.0.1.1.2 {logging}
    ]
    Status: [to-test]
]

unless value? '.redlang [
    do https://redlang.red
]
.redlang [log alias]

.xcopy: function [
    'param>source-folder [word! string! file! path! url!] 
    'param>target-folder [word! string! file! path! url! unset!] 
    /no-log
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

    switch/default type?/word get/any 'param>target-folder [
        unset! [
            param>target-folder: %./
        ]
        word! string! file! url! path! [
            param>source-folder: to-red-file form param>source-folder
            param>target-folder: to-red-file form param>target-folder

            cmd: rejoin [{XCOPY "} 
                (to-local-file param>source-folder) {*.*} {" "} 
                (to-local-file param>target-folder) {" /H /R /S /E /Y /C}
            ] 
            print cmd
            out: copy ""
            call/wait/output cmd out
            print out

            ;0.0.0.1.01.2
            .log (%xcopy.log) (out)
        ]
    ] [
        throw error 'script 'expect-arg param>source-folder
    ]
]

.alias .xcopy [xcopy]
