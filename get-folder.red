Red [
    Title: "get-folder.red"
]

do https://redlang.red/block-to-string

get-folder: function [file-path][
    folder: pick split-path file-path 1
    return folder
]

get-parent-folder: function [folder-or-file][
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

get-script-folder: function [][
    folder: pick split-path system/options/script 1
    return folder
]

