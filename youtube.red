Red [
    Title: "youtube.red"
    Builds: [
        0.0.0.1 {Initial version: id, title, description}
    ]
]

parse-url: function[>url >param-name][
    param-name: rejoin [>param-name "="]
    parse to-string >url compose [
        thru (param-name) copy param-value [
            to "?" | to end
        ]
    ]
    return param-value
]

;id: parse-url https://www.youtube.com/watch?v=GHvnIm9UEoQ 'v
;?? id

youtube: function [>id_or_url [word! string! url!]][

    if >id_or_url = 'clipboard [
        >id_or_url: read-clipboard
        if find >id_or_url "http://" [
            >id_or_url: to-url >id_or_url
        ]
    ]

    either url? >id_or_url [
        url: >id_or_url
    ][
        id: >id_or_url
        url: rejoin [https://www.youtube.com/watch?v= id]
    ]
    html: read url


    parse html [
        thru {<meta name="twitter:title" content="} copy title to {">}
        thru {<meta name="twitter:description" content="} copy description to {">}
    ]

    parse to-string url [
        thru "v=" copy id [
            to "?" | to end
        ]
    ]

    return repend [] [
        to-set-word 'id id 
        to-set-word 'title title 
        to-set-word 'description description
    ]
    
]

; test: youtube 'GHvnIm9UEoQ
test: youtube https://www.youtube.com/watch?y=10&v=GHvnIm9UEoQ
?? test