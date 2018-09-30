Red [
    Title: "Cache Management"
    File: "cache.red"
    Builds: [
        0.0.0.1.2 {Block support}
        0.0.0.1.1 {Initial version}
    ]
    GUID: #c1bbd2d0-d7d1-48b6-b3c6-a1997530bbc5
]

if not value? '.redlang [
    do https://redlang.red
]

.redlang [files]

.cache: function [
    >paths 
    /folder >lib-folder
    /force ; force update if already exists
    /update ; same as force
][

    unless folder [
        >lib-folder: %libs/
    ]
    
    .lib-folder: :>lib-folder

    either block? >paths [
        forall >paths [
            >path: >paths/1

            either folder [
                either force or update [
                    .cache/folder/force (>path) (>lib-folder)
                ][
                    .cache/folder (>path) (>lib-folder)
                ]
                
            ][
                either force or update [
                    .cache/force (>path)
                ][
                    .cache (>path)
                ]
                
            ]
            
        ]
    ][
        >path: >paths
        short-filename: get-short-filename >path
        out-file: rejoin [.lib-folder short-filename]

        ..create-out-file: does [
            print [out-file {already exists, use /force or /update to update}]
            make-dir/deep .lib-folder
            write out-file read >path      
        ]

        either exists? out-file [
            if force or update  [
                ..create-out-file
            ]
        ][
            ..create-out-file
        ]
    ]
]

if not value? 'cache [
    cache: :.cache
]
