Red [
    Title: "templating.red"
    Build: 1.0.0.1
]

do read http://redlang.red/build-markup.red

.render-template: function[>template-path /out >output-path [file!] /no-out][

    vars: .get-vars content: read >template-path

    do read http://redlang.red/do-trace
    
    foreach var vars [

        var: to-word var     
        either not value? var [
            set to-word var ask rejoin [var ": "]
        ][
            do rejoin ["?? " var]
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