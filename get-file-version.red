Red [
    Title: ""
]

do https://redlang.red
.redlang [remove-last]

.get-file-version: function ['>file][
    .file: to-red-file form :>file
    splitted-file: split .file
    remove-last splitted-file
    either error? try [
        version: to-integer last splitted-file
    ][
        return none
    ][
        return version
    ]
]

get-file-version: :.get-file-version
