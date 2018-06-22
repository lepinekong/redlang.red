Red [
    Title: "templating.red"
    Build: 1.0.0.3
    History: [
        1.0.0.3 {escape sequence \%}
        1.0.0.2 {asks only unset vars}
    ]
]

do read http://redlang.red/build-markup.red

.get-vars: function[>template][
    vars: copy []
    rules: [any [thru "<%" copy var to "%>" (append vars var)]]
    parse >template rules
    return unique vars
]

get-vars: :.get-vars

.render-template: function[>template-path /out >output-path [file!] /no-out][

    vars: .get-vars content: read >template-path

    do read http://redlang.red/do-trace
    
    foreach var vars [
        var: to-word var
        either not value? var [
            set var ask rejoin [var ": "]
        ][
            command: rejoin ["?? " var]
            do read http://redlang.red/do-trace     
            do command
        ]
        
    ] 

    either out [
        write >output-path out>
    ][
        write-clipboard out>: .build-markup content
        print "Rendered output has been copied to clipboard."
    ]

    unless no-out [
        return out>
    ]
    
]

render-template: :.render-template
render: :.render-template