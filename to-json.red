Red [
    Title: "to-json.red"
    Based-on: [
        Library: "Altjson"
        Author: "Christopher Ross-Gill"
    ]

]

do https://redlang.red/altjson

.to-json: :to-json ; for overriding to-json

to-json: function[
    >block [block! word!]
    /compact /no-clipboard-output 
    /no-tab-replace /no-newline
][

    if no-newline [
        .block: copy []
        forall >block [
            sub-block: >block/1
            new-sub-block: copy []
            foreach [field value] sub-block [
                value: replace/all value newline " "
                append new-sub-block reduce [field value]
            ]
            append/only .block new-sub-block
        ] 
        >block: copy .block       
    ]

    ;--- tab replace feature ---

        either no-tab-replace [
            .block: >block
        ][
            .block: copy []
            forall >block [
                sub-block: >block/1
                new-sub-block: copy []
                foreach [field value] sub-block [
                    value: replace/all value tab ""
                    value: replace/all value "    " ""
                    append new-sub-block reduce [field value]
                ]
                append/only .block new-sub-block
            ]
        ]

    ;---------------------------

    ;--- json conversion feature ---
    either compact [
        json-data: .to-json .block
    ][
        json-data: .to-json/pretty .block
    ]
    ;---------------------------

    ;--- clipboard feature ---

    unless no-clipboard-output [
        to-clipboard: function [>data][
            write-clipboard >data
            print ["output written to clipboard:"]
            print >data
        ]        
        to-clipboard json-data
    ]
    ;--------------------------

    return json-data
    
]
