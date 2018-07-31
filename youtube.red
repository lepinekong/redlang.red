Red [
    Title: "youtube.red"
    Builds: [
        0.0.0.1.14 {/to-json}
        0.0.0.1.13 {Cleaning}
        0.0.0.1.12 {Test OK}
        0.0.0.1.11 {Managing internet connection error}
        0.0.0.1.10 {Multiple urls support}
    ]
]

__OFFLINE__: false

if __OFFLINE__ or error? try [
    do load-thru/update https://redlang.red/url.red
    do load-thru/update https://redlang.red/to-json.red
][
    print "OFFLINE mode"
    do %libs/url.red
    do %libs/to-json.6.red
]

.parse-youtube-url: function [>youtube-url [url!] /local _counter_][

    _counter_: copy []
    if empty? _counter_ [append _counter_ 0]

    .url: >youtube-url
    if error? try [
        .html: read >youtube-url
        parse .html [
            thru {<meta name="twitter:title" content="} copy .title to {">}
            thru {<meta name="twitter:description" content="} copy .description to {">}
        ]
        ; write-clipboard .html
        .id: parse-url .url 'v        
    ][
        ans: ask {Do you want simulated data ("Y" for YES)?}
        if ans = "Y" [
            .id: "Gg84CO4L2Yw"
            .title: "How the Universe Works"
            .description: {Blow your Mind of the Universe Part 11 - Space Discovery Documentary}
        ]
    ]

    return compose [
        id: (.id)
        title: (.title)
        description: (.description)
    ]    

]

.parse-youtube: :.parse-youtube-url
parse-youtube: :.parse-youtube-url  

youtube: function [>id_or_url [word! string! url! block!] 
    /to-clipboard
    /to-json
][

    either block? >id_or_url [
        result: copy []
        >id_or_urls: >id_or_url
        forall >id_or_urls [
            >id_or_url: >id_or_urls/1
            youtube-parsed: youtube >id_or_url
            append/only result youtube-parsed         
        ]

        either to-json [
            result: system/words/to-json result
            if to-clipboard [
                write-clipboard result
                print result
                print "json data copied to clipboard"
            ]
            return result 

        ][
            if to-clipboard [
                write-clipboard mold result
                print mold result
                print "copied to clipboard"
            ]
        ]

        return result
    ][


        if >id_or_url = 'clipboard [
            >id_or_url: read-clipboard
            if find >id_or_url "http" [
                >id_or_url: to-url >id_or_url
            ]
            to-clipboard: true
        ]

        either url? >id_or_url [
            url: >id_or_url
        ][
            id: >id_or_url
            url: rejoin [https://www.youtube.com/watch?v= id]
        ]
        

        it: .parse-youtube-url url

        either to-json [
            it: system/words/to-json it
            if to-clipboard [
                write-clipboard it
                print it
                print "json data copied to clipboard"
            ]
            return result             
        ][
            if to-clipboard [
                write-clipboard mold it
                print mold it
                print "copied to clipboard"
            ]            
        ]


        return it
    ]

]




