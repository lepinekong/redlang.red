Red [
    Title: ""
]

if not value? '.redlang [
    do https://redlang.red
]

.redlang [get-folder]
get-script-file: function [][
    ;return get-short-filename system/options/script
    if system/options/script [
        return system/options/script
    ]
    return none
]

get-script-extension: function [][
    ;return get-short-filename system/options/script
    if system/options/script [
        return suffix? system/options/script
    ]
    return none
]
