Red [
    Title: "sha256.red"
]

sha256: function [>exe-path][
    checksum read/binary (to-red-file >exe-path) 'sha256
]