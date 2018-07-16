Red [
    Title: "to-json.red"
    Based-on: [
        Library: "Altjson"
        Author: "Christopher Ross-Gill"
    ]

]

do https://redlang.red/altjson

.to-json: :to-json ; for overriding to-json

to-json: function[>block [block!] /compact /no-clipboard][   

    .block: >block
    
    ;--- json conversion feature ---
    either compact [
        json-data: .to-json/pretty .block
    ][
        json-data: .to-json .block
    ]
    ;--------------------------

    ;--- clipboard feature ---
    to-clipboard: function [>data][
        write-clipboard >data
        print ["output written to clipboard:"]
        probe >data
    ]

    unless no-clipboard [
        to-clipboard json-data
    ]
    ;--------------------------

    return json-data
    
]
