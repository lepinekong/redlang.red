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
    /no-newline ; 0.0.0.4.7    
    /separator ; 0.0.0.6.6
][
    builds>: [
        0.0.0.5.1 {separator with filename}
        0.0.0.4.9 {Revert to 0.0.0.4.7 by removing newline}
    ] 

    if build [
        unless silent [
            ?? builds>
        ]
        return builds>
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
        sub-folder: rejoin [folder short-filename %/]         head-of-file: (index? files) = 1
        
        short-filename: get-short-filename file

        start-separator: func [ /local the-separator][
            the-separator: copy ""
            unless no-newline [
                if separator [
                    unless head-of-file [
                        the-separator: newline ; 0.0.0.5.8
                    ]
                    the-separator: rejoin [the-separator {;--- start } short-filename { ;---}] ; 0.0.0.5.7
                    the-separator: rejoin [the-separator newline] 
                ]
            ]

            return the-separator       
        ]

        finish-separator: func [ /local the-separator][
            the-separator: copy ""
            unless no-newline [
                either separator [            
                    the-separator: rejoin [newline {;--- finish } short-filename { ;---} newline ]
                ][
                    the-separator: newline ; 0.0.0.5.8
                ]
            ]
            return the-separator
        ]

        unless (dir? file) or (
            (extension <> %.red) and (extension <> %.html) and (extension <> %.htm)
            ) [

            src: rejoin [src (start-separator) read file (finish-separator)]

            doc-file: clean-path rejoin [folder short-filename %.log]
            
            unless exists? doc-file [
                write doc-file ""
            ]            

            if exists? sub-folder [
                src-include: .include (sub-folder) 
                replace src {<%parts%>} src-include
            ]
        ]        
    ]    return src
].alias .include [include assemble .assemble ]