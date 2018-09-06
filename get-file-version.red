Red [
    Title: ""
]

do https://redlang.red
.redlang [remove-last]

.get-file-version: function ['>file][
    .file: to-red-file form :>file
    splitted-file: split .file "."
    splitted-file: head remove-last splitted-file
    version: last splitted-file
    version: to-integer form version
    error: (error? try [
        version: to-integer version
    ])
    either error [
        return none
    ][
        return version
    ]
]

get-file-version: :.get-file-version


