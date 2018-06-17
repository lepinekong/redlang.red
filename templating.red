Red [
    Title: "templating.red"
    Build: 1.0.0.1
]

do read http://redlang.red/build-markup.red

.render-template: function[.template-path /output +output-file][
    vars: get-vars content: read .template-path
    foreach var vars [set to-word var ask rejoin [var ": "]]
    write-clipboard out: build-markup content
    print "Rendered output has been copied to clipboard."

    if output [
        write +output-file out
    ]
    return out
]
render-template: :.render-template
render: :.render-template