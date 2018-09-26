Red [
    Title: ""
]

if not value? '.redlang [
    do https://redlang.red
]
.redlang [get-folder alias]

.get-system-folder: function [][
    return .get-folder (system/options/boot)
]

alias .get-system-folder [get-system-folder]
