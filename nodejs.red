Red [
    Title: "nodejs.red"
]

do https://redlang.red/cd

nodejs: function [/folder '>folder /script '>script-name][

    folder: form >folder
    folder: to-red-file folder
    cd (folder)
    script-name: form >script-name
    command: rejoin [{cmd.exe /c node} { } script-name]
    print command
    call/wait command
]
