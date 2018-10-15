Red [
    Title: "dir.red"
]

unless value? '.redlang [
    do https://redlang.red
]
.redlang [dir-tree]

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
    dir: :.dir  
]





