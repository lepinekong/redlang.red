Red [
    Title: "make-dir.red"
    Builds: [
        0.0.0.1.10 {md alias}
    ]
]

;do http://redlang.red/do-trace

if not value? 'sysmake-dir [
    sysmake-dir: :make-dir
]

.make-dir:  function[
    '>folder [word! string! file! path! url! paren! unset!]
    /no-deep {don't create subdirectories}
    /_build {Build number for developer}
    /silent {don't print message on console}

][

    >builds: 0.0.0.1.10

    if _build [
        unless silent [
            print >builds
        ]
        return >builds
    ]


do-trace 22 [
    ?? >folder
] %make-dir.4.red


    switch/default type?/word get/any '>folder [
        unset! [
            print {TODO:}
        ]
        word! [
            .folder: get :>folder
            either no-deep [
                do c: rejoin [{sysmake-dir %} .folder] 
                print c
            ][
                do c: rejoin [{sysmake-dir/deep %} .folder] 
                print c
            ]            
        ]
        string! file! path! url! paren! [

            .folder: to-red-file  form :>folder ;0.0.0.1.9
do-trace 47 [
    ?? .folder
] %make-dir.4.red            
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
md: :.make-dir
.md: :.make-dir
create-dir: :.make-dir
.create-dir: :.make-dir
