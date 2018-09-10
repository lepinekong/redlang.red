Red [
    Title: ""
]

.create-keyword: function [
    keyword /url >url
    /force 
][
    keyword: to-word keyword

    not-value-keyword: not value? keyword

    either not-value-keyword or force [ ; 0.0.0.1.5
        if not  url [
            >url: keyword ; 0.0.0.16
        ]

        func-body: compose/deep/only [ ; 0.0.0.1.4
                go (>url) ; 0.0.0.16 
        ]
        set keyword does func-body
    ][
        ; keyword already
    ]
    return keyword
]

create-keywords: :.create-keywords
