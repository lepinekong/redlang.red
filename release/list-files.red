Red [
    Title: "list-files.red"
]

if not value? '.redlang [
    do https://redlang.red
]
.redlang [alias]

.get-list-files: function [>target-folder][
    .files: copy []
    files-and-folders: read >target-folder
    forall files-and-folders [
        if not dir? file: files-and-folders/1 [
            append .files file
        ]
    ]
    return .files
]

.alias .get-list-files [
    get-list-files
    list-files
    listfiles
]




