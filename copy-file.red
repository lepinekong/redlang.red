Red [
    Title: "copy-file.red"
]

copy-file: function [>source >target][
    write >target read >source
]
