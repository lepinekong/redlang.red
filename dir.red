Red [
    Title: "dir.red"
]


unless value? 'dir-tree [
    do https://redlang.red/dir-tree.red
]

unless value? 'sysDir [
    sysDir: :dir
]

dir: function ['>folder [any-type!] /tree ][

    either tree [
        dir-tree %./
    ][
        list-dir :>folder
    ]
]