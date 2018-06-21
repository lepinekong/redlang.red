Red [
    Title: "expand-string.red"
]

do read http://redlang.red/build-markup.red

.string.expand: function[.string-template [string!] .block-vars[block!]][

    return build-markup/bind .string-template Context Compose .block-vars
]

expand-string: :.string.expand
string.expand: :.string.expand
string-expand: :.string.expand
.expand: :.string.expand