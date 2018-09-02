Red [
    Title: "get-folder.red"
]

if not value? '.redlang [
    do https://redlang.red
]
.redlang [block-to-string alias]

.get-folder: function [
    '>file-path
    /build
][
    if build [
        >build: 0.0.0.1.8
        print >build
        exit
    ]

    .file-path: to-red-file form :>file-path

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

