Red [
    Title: ""
]

do https://redlang.red/get-folder

get-global-directory: function [][
    return get-folder (system/options/boot)
]

