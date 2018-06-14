Red [
    Title: "build-markup.red"
    Build: 1.0.0.3
    Version: 1.0.1
    History: [
        1.0.0 {Initial version}
        1.0.1 {.get-vars: return unique vars}
    ]
    Alias: [
        %build-markup
    ]
    Published-url: [
        http://redlang.red/build-markup
    ]
    Included-in: [
        http://redlang.red/authoring.red
    ]
]

.build-markup: func [
    {Return markup text replacing <%tags%> with their evaluated results.}
    content [string! file! url!]
    /bind obj [object!] "Object to bind"    ;ability to run in a local context
    /quiet "Do not show errors in the output."
    /local out eval value
][
    content: either string? content [copy content] [read content]
    out: make string! 126
    eval: func [val /local tmp] [
        either error? set/any 'tmp try [either bind [do system/words/bind load val obj] [do val]] [
            if not quiet [
                tmp: disarm :tmp
                append out reform ["***ERROR" tmp/id "in:" val]
            ]
        ] [
            if not unset? get/any 'tmp [append out :tmp]
        ]
    ]
    parse content [
        any [
            end break
            | "<%" [copy value to "%>" 2 skip | copy value to end] (eval value)
            | copy value [to "<%" | to end] (append out value)
        ]
    ]
    out
]

build-markup: :.build-markup

.get-vars: function[template][
    vars: copy []
    rules: [any [thru "<%" copy var to "%>" (append vars var)]]
    parse template rules
    return unique vars
]

get-vars: :.get-vars

.string.expand: function[.string-template [string!] .block-vars[block!]][

    return build-markup/bind .string-template Context Compose .block-vars
]

expand-string: :.string.expand
string.expand: :.string.expand
string-expand: :.string.expand
.expand: :.string.expand