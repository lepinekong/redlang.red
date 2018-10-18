Red [
    Title: "to-file.red"
    In: [
        %authoring.red
        %lib-files.red
    ]
]

.to-file: function [.file [file! string! word! url! path! block!]][

    either block? .file [
        return to-red-file rejoin .file
    ][
        return to-red-file form .file
    ]
    
]  

to-file: :.to-file
