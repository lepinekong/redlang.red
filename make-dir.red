Red [
    Title: "make-dir.red"
]

if not value? 'sysmake-dir [
    sysmake-dir: :make-dir
]

.make-dir:  function[
    '>folder [word! string! file! path! url! paren! unset!]
    /no-deep {don't create subdirectories}
    /build {Build number for developer}
][

    >build: 0.0.0.1.4

    if build [
        print >build
        return >build
    ]


    switch/default type?/word get/any '>folder [
        unset! [
            print {TODO:}
        ]
        word! string! file! path! url! paren! [

            .folder: form :>folder
            either no-deep [
                do c: rejoin [{sysmake-dir %} .folder] 
                print c
            ][
                do c: rejoin [{sysmake-dir/deep %} .folder] 
                print c
            ]
        ]
    ] [
        throw error 'script 'expect-arg >folder
    ]
]

make-dir: :.make-dir

