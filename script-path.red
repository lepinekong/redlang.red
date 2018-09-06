Red [
    Title: "self-path.red"
]

if not value? '.redlang [
    do https://redlang.red
]

.redlang [files]
script-path: function [][
    return get-short-filename system/options/script
]
