Red [
    Title: "parse-text-data.red"
]

.parse-text-data: function[.data][

    comment {
        ; data can be pasted from excel https://office.live.com/start/Excel.aspx
        ; example:
        data: parse-text-data {
            Adsense Revenue	300
            Sponsors	500
            Gifts	50
            Others	58  
        }
        ?? data
    }

    data: .data

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
            try [
                data: to-float data
            ]
            append data-block data
        ] 
    ]

    ;?? data-block ask "pause..." ; for debugging
    return data-block ; data-block: ["Adsense Revenue" 300.0 "Sponsors" 500.0 "Gifts" 50.0 "Others" 58.0]

]

parse-text-data: :.parse-text-data