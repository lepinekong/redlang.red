Red [
    Title: "get-folder.red"
    Iterations: [
        0.0.0.3.11 {Refactoring 10}
    ]
]

if not value? '.redlang [
    do https://redlang.red
]
.redlang [block-to-string alias]

.get-folder: function [
    {Examples:
        get-folder %/C/ProgramData/Red/gui-console-2018-6-18-47628.exe
        get-folder system/options/boot/
    }
    '>file-path
    /build
][
    if build [
        >build: 0.0.0.1.10
        print >build
        exit
    ]

    either (path? >file-path) and (value? .file-path) [
        ; either value? .file-path [    
        ;     .file-path: get .file-path
        ; ][
        ;     .file-path: :>file-path
        ; ]
    ][
        .file-path: :>file-path
    ]

    .file-path: to-red-file .file-path
    
    folder>: pick split-path .file-path 1
    return folder>
]

alias .get-folder [get-folder]

.get-parent-folder: function [folder-or-file][
    folder: folder-or-file
    unless dir? folder-or-file [
        folder: get-folder folder-or-file
        ?? folder
    ]
    decomposed-folders: split folder "/"
    ?? decomposed-folders
    remove back tail decomposed-folders
    parent-folder: to-red-file rejoin [(block-to-string decomposed-folders "/") "/"]
    return parent-folder
]
alias .get-parent-folder [get-parent-folder]

.get-script-folder: function [][
    folder: pick split-path system/options/script 1
    return folder
]

alias .get-script-folder [get-script-folder]

