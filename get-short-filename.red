Red [
    Title: ""
]

.get-short-filename: function[.filepath [file! url!] /wo-extension /without-extension][

    filepath: .filepath
    short-filename: (pick (split-path .filepath) 2)
    unless (without-extension or wo-extension) [
        return short-filename
    ]
    return (pick (.split-filename short-filename) 1)
    
]

get-short-filename: :.get-short-filename
get-short-filename-without-extension: function [.filepath [file! url!]][
    .get-short-filename/wo-extension .filepath
]
