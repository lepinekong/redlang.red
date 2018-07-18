Red [
    Title: "url.red"
]

parse-url: function[>url >param-name][
    param-name: rejoin [>param-name "="]
    parse to-string >url compose [
        thru (param-name) copy param-value [
            to "&" | to end
        ]
    ]
    return param-value
]

;id: parse-url https://www.youtube.com/watch?v=GHvnIm9UEoQ 'v
;?? id