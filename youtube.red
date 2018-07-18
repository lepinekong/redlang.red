Red [
    Title: "youtube.red"
    Builds: [
        0.0.0.1.5 {Bug fixed youtube 'clipboard}
        0.0.0.1.4 {
            KO test: youtube 'clipboard
            ->
            >youtube-url: https://www.youtube.com/watch?v=https://www.youtube.com/watch?v=mKFGj8sK5R8&t=2s
            pause...
            if find >id_or_url "http://" [
            should be
            if find >id_or_url "http" [
        }
        0.0.0.1.3 {
            bugs:
            
            1/ youtube https://www.youtube.com/watch?v=mKFGj8sK5R8&t=2s
            id: "mKFGj8sK5R8&t=2s" => fixed

            2/ youtube 'clipboard
            *** Script Error: .title has no value => still unfixed

        }        
        0.0.0.1.2 {
            bugs:
            
            1/ youtube https://www.youtube.com/watch?v=mKFGj8sK5R8&t=2s
            id: "mKFGj8sK5R8&t=2s"

            2/ youtube 'clipboard
            *** Script Error: .title has no value

        }
        0.0.0.1.1 {Initial version: id, title, description}
    ]
]


do load-thru https://redlang.red/url.red


.parse-youtube-url: function [>youtube-url [url!]][

    .url: >youtube-url
    .html: read >youtube-url

    ?? >youtube-url
    write-clipboard .html
    ask "pause..."

    parse .html [
        thru {<meta name="twitter:title" content="} copy .title to {">}
        thru {<meta name="twitter:description" content="} copy .description to {">}
    ]


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

    if to-clipboard [
        write-clipboard mold it
        print mold it
        print "copied to clipboard"
    ]
    return it
]

; test: youtube 'GHvnIm9UEoQ
;test: youtube/to-clipboard https://www.youtube.com/watch?y=10&v=GHvnIm9UEoQ
;test: youtube https://www.youtube.com/watch?v=mKFGj8sK5R8&t=2s
;?? test

; test: youtube https://www.youtube.com/watch?v=mKFGj8sK5R8&t=2s
; ?? test

;test: youtube 'clipboard


