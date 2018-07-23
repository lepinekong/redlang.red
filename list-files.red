Red [
    Title: "list-files.red"
]

list-files: function [>target-folder][
    .files: copy []
    files-and-folders: read >target-folder
    forall files-and-folders [
        if not dir? file: files-and-folders/1 [
            append .files file
        ]
    ]
    return .files
]

