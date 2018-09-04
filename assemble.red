
Red [
    Title: "assemble.red"
    Description: {Assemble a red file from parts}
    Version: [
        0.0.1 {Initial version}
    ]
]

do https://redlang.red
.redlang [files get-folder alias to-dir]

.include: function [
    'directory [any-type! unset!]
    /build
    /silent
][

    >build: 0.0.0.4.4

    if build [
        unless silent [
            print >build
        ]
        return >build
    ]    
    src: copy ""
    >directory: directory ; new in 0.0.0.4

    directory: .to-dir to-red-file form :directory

    ; new in 0.0.0.4
    if not exists? directory [
        if value? to-word >directory [
            directory: get :>directory
        ]
    ]

    files: read directory

    forall files [
        file: rejoin [directory files/1]

            short-filename: rejoin [get-short-filename/wo-extension file]
            extension: get-file-extension file

            folder: get-folder (file)
            sub-folder: rejoin [folder short-filename %/] ; fixed bug: missing %/

        unless (dir? file) or (
            (extension <> %.red) and (extension <> %.html) and (extension <> %.htm)
            ) [
            unless (index? files) = 1 [
                src: rejoin [src newline]
            ]
            src: rejoin [src read file]

            doc-file: clean-path rejoin [folder short-filename %.log]
            ; txt-file: clean-path rejoin [folder short-filename %.txt]

            ; if exists? txt-file [
            ;     write doc-file read txt-file
            ;     delete txt-file
            ; ]
            
            unless exists? doc-file [
                write doc-file ""
            ]            

            if exists? sub-folder [
                ;src-include: .include sub-folder ; super bug missing () in assemble.1.red
                src-include: .include (sub-folder) ; super bug fixed () in assemble.2.red

                replace src {<%parts%>} src-include
            ]
        ]
    ]
    return src
]
.alias .include [include assemble .assemble ]