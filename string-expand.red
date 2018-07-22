Red [
    Title: "string-expand.red"
]

do https://redlang.red/build-markup

.string.expand: function[.string-template [string!] .block-vars[block!]][
    return build-markup/bind .string-template Context Compose .block-vars
]

string-expand: :.string.expand
.expand: :.string.expand