Red [
    title: ".system.libraries.string.red"
    uses: [
        %.system.libraries.string.template.red
    ]
]    

unless try [.do %.system.libraries.string.template.red][]
;for remote execution
unless value? 'build-markup [
    github-url-entry: https://gist.github.com/lepinekong/f007c5358104f0469d8b1ea7da11650e
    lib: get-github-url github-url-entry %.system.libraries.string.template.red
    do read lib    
]

.string.compose: function [.string-block [block!] /separator .separator][

	{

        #### Example:
        - [x] [1]. .string.compose ["a" "b" "c"]     
    }

    string-block: copy []
    
    either separator [
        append string-block .string-block/1
        foreach string skip .string-block 1 [
            append string-block .separator
            append string-block string
        ]
    ][
        string-block: copy .string-block  
    ]
    return rejoin compose string-block
]

string.compose: :.string.compose
compose-string: :string.compose

.string.expand: function[.string-template [string!] .block-vars[block!]][

    return build-markup/bind .string-template Context Compose .block-vars
]

string-expand: :.string.expand
.expand: :.string.expand

.string.trim: function [.string][
    return trim/head/tail .string
]

.trim: :.string.trim 

.string.start.with: function[_url _prefix][

    url: to-string _url
    prefix: _prefix

    found: find url prefix

    if none? found [
        return false
    ]

    either (index? found) = 1 [
        return true
    ][
        return false
    ]
]

string.start.with: :.string.start.with
string.start-with: :.string.start.with
.start.with: :.string.start.with
start.with: :.string.start.with
start-with: :.string.start.with

.string.contains: function [.full-string .searched-string][

    either find .full-string .searched-string [
        return true
    ][
        return false
    ]

]

.pad-left: function [.string [string! number!] n [integer!]][
    string: form .string
    pad/left/with string n #"0"
]

pad-left: :.pad-left

.replace: function [
    series [series! none!] 
    pattern 
    value 
    /all 
][
    if error? try [
        either all [
            replace/all series pattern value
            return series
        ][
            replace series pattern value
            return series
        ]
        
    ][
        return none
    ]
]


