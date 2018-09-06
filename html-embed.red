Red [
    Title: "blank-template.red"
    Iterations: [
        0.0.0.1.5 {Deleted call}
        0.0.0.1.4 {Fix ask domain error}
        0.0.0.1.3 {Confirm domain-name - bugged when asking domain: 
*** Script Error: ask does not allow block! for its question argument        
        }
        0.0.0.1.2 {unset 'short-filename}
        0.0.0.1.1 {Initial version}
    ]
]

do https://codegen.red/blank-template.red

if not value? '.redlang [
    do https://redlang.red
]
.redlang [templating]


html-embed: function [][    
    store-template: copy []
    if empty? store-template [
        append store-template get-blank-template/source/no-clipboard-output 
        https://codegen.red/redlang/res/html-embed.template.html ; 0.0.0.1.2: /no-clipboard-output
    ]
    
    template: store-template/1

    if value? 'short-filename [
        unset 'short-filename
    ]

    unless not value? 'domain-name [
        ans: ask rejoin ["Confirm domain-name" domain-name "(by default or give new domain):"]
        if ans <> "" [
            system/words/domain-name: ans
        ]
    ]
    if value? '>short-filename [
        short-filename: >short-filename
    ]
    return render template %html-embed.html
]

.redlang [script-path get-short-filename confirm]
file: get-script-file
if file [
    >short-filename: get-short-filename file
    block: reverse split form file "."

    if (block/1 = "red") and (block/2 = "html") [
        src: html-embed
        if confirm (rejoin [{Write to } file { ?}]) [
            write file src
        ]
    ]
]


