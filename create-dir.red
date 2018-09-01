Red [
    Title: "create-dir.red"
]

.make-dir:  function['>folder [word! string! file! url! block! unset!] /local ][
    switch/default type?/word get/any '>folder [
        unset! [
            print {TODO:}
        ]
        word! string! file! url! block! [
            >folder: form :>folder
            print {TODO:}
        ]
    ] [
        throw error 'script 'expect-arg >folder
    ]
]

do https://redlang.red/alias
