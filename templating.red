Red [
    Title: "templating.red"
    Build: 1.0.0.1
]

do read http://redlang.red/build-markup.red

.render-template: function[>template-path /out >output-path [file!] /no-return][

    vars: .get-vars content: read >template-path

    foreach var vars [
        set to-word var ask rejoin [var ": "]
    ]

    either out [
        write >output-path out>
    ][
        write-clipboard out>: .build-markup content
        print "Rendered output has been copied to clipboard."
    ]

    unless no-return [
        return out>
    ]
    
]

render-template: :.render-template
render: :.render-template