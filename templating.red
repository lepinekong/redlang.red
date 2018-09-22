Red [
    Title: "templating.red"
    Description: {Will render a string or a file templating.}
    Features: [
        1 {support file or string for template source}
        2 {will ask for values automatically}
        3 {supports values provided in data refinement. if some values}
        3.1 {If some values are not provided in data will ask for these values}
    ]
    Build: [
        0.0.0.3.7 {case none}
        0.0.0.3.6 {Support new refinement /only complement to /data}
        0.0.0.3 {Support new refinement /data}
    ]
]

__OFFLINE__: false

if __OFFLINE__ or error? try [
    do http://redlang.red/build-markup
][
    do %libs/build-markup.red
]

.ask-field: function ['>fieldName /area][
    fieldName: form >fieldName
    win: compose/deep [
        text (rejoin [fieldName ":"]) fName: (either area ['area]['field]) ""
        return
        button "OK" [val: fName/text unview] button "cancel" [val: none unview]
    ]
    view win
    return val
]
ask-field: :.ask-field

.get-vars: function[>template][
    vars: copy []
    rules: [any [thru "<%" copy var to "%>" (append vars var)]]
    parse >template rules
    return unique vars
]

get-vars: :.get-vars

.render-template: function[
    >template 
    /data 
    >data 
    /only ; only substitute variables listed in data
    /out >output-path [file!] /no-out
    /_build
    /silent
][
    builds: [
        0.0.0.4.14 {area field support}
    ]
    if _build [
        unless silent [
            ?? builds
        ]
        return builds
    ]

    either string? >template [
        content: >template
    ][
        >template-path: >template
        content: read >template-path
    ]

    vars: .get-vars content
    if not none? >data [
        data-vars: extract >data 2
    ]

    either data [
        block: copy []
        ask-vars: function [vars /gui][

            commands: copy []

            foreach var vars [
                field-type: "field"
                if find var "/area" [
                    splitted-var: split var "/"
                    var: splitted-var/1
                    field-type: splitted-var/2
                ]
                var: to-word var
                value: select >data var

                if none? value [
                    either only and not none? >data [
                        either find data-vars var [
                            ;value: ask rejoin [var ": "]
                            either field-type = "field" [
                                value: .ask-field (var)
                            ][
                                value: .ask-field/area (var)
                            ]
                            
                        ][
                            value: rejoin ["<%" form var "%>"]
                        ]
                    ][
                        ;value: ask rejoin [var ": "]
                        either field-type = "field" [
                            value: .ask-field (var)
                        ][
                            value: .ask-field/area (var)
                        ]
                    ]
                ]

                append block reduce [
                    to-set-word var value
                ]
            ]            
        ]
        ask-vars/gui vars

        ;?? block
        ; block: [title: "test render/data" email: "the email" author: "the author" version: "1.0"]

        out>: .build-markup/bind content context block  
        
    ][

        ask-vars: function [vars /gui][
            commands: copy []
            foreach var vars [
                field-type: "field"
                if find var "/area" [
                    splitted-var: split var "/"
                    var: splitted-var/1
                    field-type: splitted-var/2
                ]                
                var: to-word var
                either not value? var [
                    either gui [
                        either field-type = "field" [
                            ;value: .ask-field (var)
                            append commands [set var .ask-field]
                        ][
                            ;value: .ask-field/area (var)
                            append commands [set var .ask-field/area]
                        ]                        
                        ;append commands [set var .ask-field]
                    ][
                        append commands [set var ask rejoin [var ": "]]
                    ]
                ][
                    command: rejoin ["?? " var]
                    append commands command
                    ;do command
                ]
            ]       
            do commands     
        ]    

        ask-vars/gui vars
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