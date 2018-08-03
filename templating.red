Red [
    Title: "templating.red"
    Description: {Will render a string or a file templating.}
    Features: [
        1 {support file or string for template source}
        2 {will ask for values automatically}
        3 {supports values provided in data refinement. if some values}
        3.1 {If some values are not provided in data will ask for these values}
    ]
    Build: [0.0.0.3 {Support new refinement /data }]
]

__OFFLINE__: false

if __OFFLINE__ or error? try [
    do http://redlang.red/build-markup
][
    do %libs/build-markup.red
]

.get-vars: function[>template][
    vars: copy []
    rules: [any [thru "<%" copy var to "%>" (append vars var)]]
    parse >template rules
    return unique vars
]

get-vars: :.get-vars

.render-template: function[>template /data >data /out >output-path [file!] /no-out][

    either string? >template [
        content: >template
    ][
        >template-path: >template
        content: read >template-path
    ]

    vars: .get-vars content
    
    either data [
        block: copy []
        foreach var vars [
            var: to-word var
            value: select >data var
            if none? value [
                value: ask rejoin [var ": "]
            ]
            append block reduce [
                to-set-word var value
            ]
        ]

        out>: .build-markup/bind content context block                       
    ][
        foreach var vars [
            var: to-word var
            either not value? var [
                set var ask rejoin [var ": "]
            ][
                command: rejoin ["?? " var]
                do command
            ]
        ]

        out>: .build-markup content

    ]

    replace/all out> {<\%} {<%}
    replace/all out> {\%>} {%>}       

    either out [
        write >output-path out>
    ][
        write-clipboard out>
        print "Rendered output has been copied to clipboard."
    ]

    unless no-out [
        return out>
    ] 
    
]

render-template: :.render-template
render: :.render-template