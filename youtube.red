Red [
    Title: "youtube.red"
    Builds: [
        0.0.0.2.4 {/force-update}
        0.0.0.2.3 {don't override existing data when saving}
        0.0.0.2.2 {/save}
        0.0.0.2.1 {file! arg}
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


.youtube: function [
    >id_or_url [
        word! string! url! 
        block!
        file!
    ] 
    /to-clipboard
    /to-json
    /save target-file
    /force-update
][

    if file? >id_or_url [
        >id_or_url: load >id_or_url
    ]

    either block? >id_or_url [
        result: copy []
        >id_or_urls: >id_or_url
        forall >id_or_urls [
            >id_or_url: >id_or_urls/1
            youtube-parsed: .youtube >id_or_url
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

        if save [
            system/words/save target-file result
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

        if save [
            if exists? target-file [
                unless force-update [
                    existing-data: load target-file
                    existing-ids: copy []
                    forall existing-data [
                        data: existing-data/1
                        append existing-ids data/id
                    ]
                    new-ids: copy []
                    forall it [
                        data: it/1
                        append new-ids data/id
                    ]
                    diff: difference new-ids existing-ids
                    new-datas: copy []
                    forall it [
                        data: it/1
                        id: data/id
                        if find diff id [
                            append/only new-datas data
                        ]
                    ]
                    it: copy new-datas
                ]

                
            ]
            system/words/save target-file it
        ]
        return it
    ]

]

if not value? 'youtube [
    youtube: :.youtube
]

; dependencies

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




