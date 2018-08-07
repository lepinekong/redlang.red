Red [
    Title: "cache-library.red"
]

.cache-library: function [>url][
    if error? try [
        return load-thru/update >url
    ][
        if error? try [
            print [{internet connection error,} >url {loaded from cache}]
            return load-thru >url
        ][
            print [{internet connection error,} >url {cannot be loaded from cache}]
            return none
        ]
    ]
]

cache-library: :.cache-library

.do-cache-library: function [>url][
    if not none? library-code: cache-library >url [
        do library-code
    ]
]

do-cache: :.do-cache-library
do-cache-library: :.do-cache-library