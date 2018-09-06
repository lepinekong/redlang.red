Red [
    Title: ""
]

do https://redlang.red
.redlang [remove-last]

.get-file-without-version: function ['>file][
    .file: to-red-file form :>file
    splitted-file: split .file "."
    file>: remove-last remove-last splitted-file
    append file> (suffix? .file)
    file>: rejoin file>
    return file>
]

get-file-without-version: :.get-file-without-version


