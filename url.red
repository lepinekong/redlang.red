Red [
    Title: "url.red"
    Iterations: [
        0.0.0.2.3 {cleaning}
        0.0.0.2.2 {Bug fixed}
        0.0.0.2.1 {Refactoring to fix
        > parse-url https://www.youtube.com/watch?v=mKFGj8sK5R8&t=2s 'v
        == "mKFGj8sK5R8&t=2s"
        }
    ]
]

parse-url: function[>url >param-name][

    >url: to-string >url

    param-name: rejoin [>param-name "="]

    delimiters: charset "&?="

    block: split >url delimiters
    param-value: select block "v"
    return param-value
]

;id: parse-url https://www.youtube.com/watch?v=GHvnIm9UEoQ 'v
;?? id

; id: parse-url https://www.youtube.com/watch?v=mKFGj8sK5R8&t=2s 'v
; ?? id


