Red [
    Title: "nodejs.red"
]

do https://redlang.red/cd

nodejs: function [/folder '>folder /script '>script][

    either folder [
        script-folder: form >folder
        script-folder: to-red-file folder
    ][
        either script [
            script-path: to-red-file form >script
            script-folder: pick split-path script-path 1
            script-name: form pick split-path script-path 2
        ][
            script-folder: request-dir
            if exists? %index.js [
                >script-name: "index.js"
            ]
        ]
    ]
    cd (script-folder)
    print what-dir

    script-name: form >script-name
    command: rejoin [{cmd.exe /c node} { } script-name]
    print command
    call/wait command
]
