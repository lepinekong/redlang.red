Red [
    Title: "self-path.red"
]

if not value? '.redlang [
    do https://redlang.red
]

.redlang [get-folder]
get-script-path: function [][
    ;return get-short-filename system/options/script
    if system/options/script [
        return get-folder system/options/script
    ]
    return none
]

