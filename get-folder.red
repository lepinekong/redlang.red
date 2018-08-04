Red [
    Title: "get-folder.red"
]

get-folder: function [file-path][
    folder: pick split-path file-path 1
    return folder
]