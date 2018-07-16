Red [
    Title: "to-json.red"
    Based-on: [
        Library: "Altjson"
        Author: "Christopher Ross-Gill"
    ]
    Builds: [
        0.0.0.1 {Initial version}
    ]

]

do https://redlang.red/altjson

.to-json: :to-json ; for overriding to-json

to-json: function[
    >block [block! word!]
    /compact /no-clipboard-output 
    /no-tab-replace /no-newline
][

    ;--- no-newline feature ---

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
    ;---------------------------

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

Youtube: [
    [
        id: {ov00SrBwjKQ}
        title: {What Darwin Never Knew}
        description: {The source of life's endless forms was a profound mystery until Charles Darwin's revolutionary idea of natural selection.
        NOVA reveals answers to the riddles that Darwin couldn't explain.}
    ]
    [
        id: {4XNMCTBdQtk}
        title: {Will the Earths Magnetic Fields Shift?}
        description: {Is the Earth losing its magnetic field and doomed to a fate similar to Mars? Many scientists believe the answer lies in paleomagnetic data, and that this weakening may be a precursor to a magnetic field reversal.}
    ]
    [
        id: {eHnwtkfX2k4}
        title: {The City of London, the Corporation that runs it}
        description: {A secret state within a state, with deleterious effects on democracy, politics and economics in London, the country, and the world, for the City is joint headquarters with Wall Street of global finance capital. 
        In short, 'Secret City' isn't just a film for Londoners - especially in these times of crisis, the role of the City concerns everyone everywhere.}
    ]
]

to-json/no-newline Youtube

