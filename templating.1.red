Red [
    Title: "templating.red"
    Build: 0.0.0.2
    Iterations: [
        0.0.0.2.3 {do http://redlang.red/build-markup}
        0.0.0.2.1 {Added to 0.0.0.1 : 
    either string? >template [
        content: >template
    ][
        >template-path: >template
        content: read >template-path
    ]        
        }
    ]
]

do http://redlang.red/build-markup

.get-vars: function[>template][
    vars: copy []
    rules: [any [thru "<%" copy var to "%>" (append vars var)]]
    parse >template rules
    return unique vars
]

get-vars: :.get-vars

.render-template: function[>template /out >output-path [file!] /no-out][

    either string? >template [
        content: >template
    ][
        >template-path: >template
        content: read >template-path
    ]

    vars: .get-vars content
    
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