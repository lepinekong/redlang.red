Red [
    Title: "parse-text-data.red"
    Build: 1.0.0.1   
    Url: http://redlang.red/parse-text-data.red
    Origin: http://mycodesnippets.space/redlang/parse-text-data
]

.parse-text-data: function[.data /clipboard][

    comment {
        ; data can be pasted from excel https://office.live.com/start/Excel.aspx

        ; example 1:
        ; do read http://redlang.red/parse-text-data.red
        ; data-block: parse-text-data {
        ;     Adsense Revenue	300
        ;     Sponsors	500
        ;     Gifts	50
        ;     Others	58  
        ; } 
        ; ?? data-block

        ; example 2:
        ; do read http://redlang.red/parse-text-data.red
        ; data-block: parse-text-data {
        ;     "Adsense Revenue"	300
        ;     "Sponsors"	500
        ;     "Gifts"	50
        ;     "Others"	58  
        ; } 
        ; ?? data-block        
    }

    either clipboard [
        data: parse-text-data read-clipboard 
    ][
        data: .data
    ]
    
    delimiters: charset "^/^(tab)^(line)" ; see http://www.rebol.com/r3/docs/datatypes/char.html
    data-block: split data delimiters
    forall data-block [
        data: data-block/1
        change data (trim/head/tail data)
    ]

    data-block0: copy data-block
    data-block: copy []
    forall data-block0 [
        data: data-block0/1
        if not (data = "") [

            if error? try [
                data: to-float data
            ][
                if (((first data) = #"^"") and ((last data) = #"^"")) [ ; example: "Adsense revenu"
                    remove data
                    remove back tail data
                ]
            ]
            append data-block data
        ] 
    ]

    ;?? data-block ask "pause..." ; for debugging
    return data-block ; data-block: ["Adsense Revenue" 300.0 "Sponsors" 500.0 "Gifts" 50.0 "Others" 58.0]

]

parse-text-data: :.parse-text-data
