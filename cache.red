Red [
    Title: "Cache Management"
    File: "cache.red"
]

do https://redlang.red
.redlang [files]

.cache: function [
    path 
    /folder >lib-folder
    /force
][

    unless folder [
        >lib-folder: %libs/
    ]
    .lib-folder: :>lib-folder
    short-filename: get-short-filename path
    out-file: rejoin [.lib-folder short-filename]

    create-out-file: does [
        make-dir/deep .lib-folder
        write out-file read path        
    ]

    either exists? out-file [
        if force   [
            create-out-file
        ]
    ][
        create-out-file
    ]
]