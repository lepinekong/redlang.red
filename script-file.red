Red [
    Title: ""
]

if not value? '.redlang [
    do https://redlang.red
]


get-script-file: function [][
    if system/options/script [
        return system/options/script
    ]
    return none
]

.redlang [get-folder]
get-script-folder: function [][
    if system/options/script [
        return get-folder system/options/script
    ]
    return none
]

get-script-extension: function [][
    if system/options/script [
        return suffix? system/options/script
    ]
    return none
]
