
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
    /separator ; 0.0.0.6.6
][

    >build: 0.0.0.4.5

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
        sub-folder: rejoin [folder short-filename %/] 
        unless (dir? file) or (
            (extension <> %.red) and (extension <> %.html) and (extension <> %.htm)
            ) [
            if separator [ ; 0.0.0.4.6
                src: rejoin [{;---} newline src]
            ]
            unless (index? files) = 1 [
                either separator [ ; 0.0.0.4.6
                    ;src: rejoin [src newline]
                ][
                    src: rejoin [src ""] ; 0.0.0.4.5
                ] 
            ]
            src: rejoin [src read file]
            if separator [ ; 0.0.0.4.6
                src: rejoin [src newline {;---} ]
            ]            

            doc-file: clean-path rejoin [folder short-filename %.log]
            
            unless exists? doc-file [
                write doc-file ""
            ]            

            if exists? sub-folder [
                src-include: .include (sub-folder) 
                replace src {<%parts%>} src-include
            ]
        ]        
    ]
    return src
]
.alias .include [include assemble .assemble ]