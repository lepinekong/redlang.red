Red [
    Title: "dir.red"
]


unless value? 'dir-tree [
    do https://redlang.red/dir-tree.red
]

unless value? '.dir [
    .dir: function [
        /only
][
        either only [
            print dir-tree/expand %./ 1
        ][
            print return>value: dir-tree/expand %./ 1
            return return>value
        ]
    ]
        
]

; TODO:
; unless value? 'sysDir [
;     sysDir: :dir
; ]

; dir: function ['>folder [any-type!] /tree ][

;     either tree [
;         dir-tree %./
;     ][
;         list-dir :>folder
;     ]
; ]
