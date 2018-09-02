Red [
    Title: "Cache Management"
    File: "cache.red"
]

__CACHING__: true

do https://redlang.red
.redlang [files]

.cache: function [
    path 
    /folder >lib-folder
][
    unless folder [
        >lib-folder: %libs/
    ]
    .lib-folder: :>lib-folder

    short-filename: get-short-filename path
    make-dir/deep .lib-folder
    out-file: rejoin [.lib-folder short-filename]
    write out-file read path
]

.cache https://redlang.red/assemble.red

