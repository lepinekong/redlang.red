Red [
    Title: "copy-file.red"
]

copy-file: function [>source >target][
    write >target read >source
]


copy-files: function[>list [block!]][

    forall list: >list [
        files: list/1
        source: files/1
        target: files/2
        copy-file source target   
    ]
]