Red [
    Title: "youtube.red"
    Builds: [
        0.0.0.1 {Initial version: id, title, description}
    ]
]

; parse-url: function[>url >param-name][
;     param-name: rejoin [>param-name "="]
;     parse to-string >url compose [
;         thru (param-name) copy param-value [
;             to "?" | to end
;         ]
;     ]
;     return param-value
; ]

do load-thru https://redlang.red/url.red

; id: parse-url https://www.youtube.com/watch?v=GHvnIm9UEoQ 'v
; ?? id

.parse-youtube-url: function [>youtube-url [url!]][

    .url: >youtube-url
    .html: read >youtube-url

    parse .html [
        thru {<meta name="twitter:title" content="} copy .title to {">}
        thru {<meta name="twitter:description" content="} copy .description to {">}
    ]

    ; parse to-string url [
    ;     thru "v=" copy id [
    ;         to "?" | to end
    ;     ]
    ; ]

    .id: parse-url .url 'v

    return repend [] [
        to-set-word 'id .id 
        to-set-word 'title .title 
        to-set-word 'description .description
    ] 

]

youtube: function [>id_or_url [word! string! url!] /to-clipboard][

    if >id_or_url = 'clipboard [
        >id_or_url: read-clipboard
        if find >id_or_url "http://" [
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

    ; html: read url

    ; parse html [
    ;     thru {<meta name="twitter:title" content="} copy title to {">}
    ;     thru {<meta name="twitter:description" content="} copy description to {">}
    ; ]

    ; ; parse to-string url [
    ; ;     thru "v=" copy id [
    ; ;         to "?" | to end
    ; ;     ]
    ; ; ]

    ; id: parse-url url 'v

    ; return repend [] [
    ;     to-set-word 'id id 
    ;     to-set-word 'title title 
    ;     to-set-word 'description description
    ; ]
    
    if to-clipboard [
        write-clipboard mold it
        print mold it
        print "copied to clipboard"
    ]
    return it
]

; test: youtube 'GHvnIm9UEoQ
test: youtube/to-clipboard https://www.youtube.com/watch?y=10&v=GHvnIm9UEoQ
