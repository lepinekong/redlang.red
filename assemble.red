Red [
    Title: "assemble.red"
    Description: {Assemble a red file from parts}
    Version: [
        0.0.1 {Initial version}
    ]
]

do https://redlang.red/files
do https://redlang.red/get-folder

include: function [directory][
    src: copy ""
    
    files: read directory

    forall files [
        file: rejoin [directory files/1]

            short-filename: rejoin [get-short-filename/wo-extension file]
            extension: get-file-extension file

            folder: get-folder file
            sub-folder: rejoin [folder short-filename %/] ; fixed bug: missing %/

        unless (dir? file) or (extension <> %.red) [
            unless (index? files) = 1 [
                src: rejoin [src newline]
            ]
            src: rejoin [src read file]

            doc-file: clean-path rejoin [folder short-filename %.txt]
            
            unless exists? doc-file [
                write doc-file ""
            ]            

            if exists? sub-folder [
                src-include: include sub-folder
                replace src {<%parts%>} src-include
            ]
        ]
    ]
    return src
]

