Red [
    Title: "to-json.red"
    Url: https://github.com/lepinekong/redlang.red/blob/master/tests/to-json/to-json.red
    Based-on: [
        Library: "Altjson"
        Author: "Christopher Ross-Gill"
    ]    

]

do https://redlang.red/altjson.red
do https://redlang.red/do-trace

.to-json: :to-json ; for overriding to-json

to-json: function[
    >block [block!] 

    /compact /no-clipboard-output 
    /no-tab-replace /no-newline

    /fields >fields ; TODO
    /from-csv /from-readable ; TODO
][

    if fields [>fields?: true] ; just to type refinement for clarity

    ;from-csv: TODO:
    ;from-readable: TODO:  

    either block? >block/1 [
        .block: >block
    ][
        ; if non standard format (user forgot all enclosing brackets)
        ; then automatically detect fields for user

        >fields?: true;
        .fields: copy []
        .values: copy []
        foreach [.field  .value] >block [
            either none? find .fields .field [
                append .fields .field
                append .values .value
            ][
                append .values .value
            ]
        ]        
    ]

    if >fields? [
        either not value? .fields [
            .fields: >fields
        ][
            .block: copy []
            foreach (.fields) .values [
                row: copy []
                forall .fields [
                    .field: .fields/1
                    append row .field
                    .value: get (to-word .field) ; gives empty value
                    append row .value
                ]
                append/only .block row
                
            ]
        ]
    ] 

    ;---------------------------

    ;--- no-newline feature ---
    if no-newline [

        ;do read http://redlang.red/do-trace
        do-trace 79 [
            ?? .block
        ] %to-json.4.red
        

        .new-block: copy []
        n: length? .block ; 3

        forall .block [

            i: index? .block
            sub-block: .block/1
            new-sub-block: copy []

        ;do read http://redlang.red/do-trace
        do-trace 93 [
            ?? n ; 3
            ?? i ; i <= n how can i reach 4 ?!!!
            ?? sub-block
        ] %to-json.3.red

            foreach [field value] sub-block [
                value: replace/all value newline " "
                append new-sub-block reduce [field value]
            ]
            append/only .block new-sub-block
        ] 
        
        .block: copy .new-block     
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

;convert [id: 1 desc: "description"] to [[id: 1 desc: "description"]]
to-json/no-newline Youtube: [

    id: {ov00SrBwjKQ}
    title: {What Darwin Never Knew}
    description: {The source of life's endless forms was a profound mystery until Charles Darwin's revolutionary idea of natural selection.
    NOVA reveals answers to the riddles that Darwin couldn't explain.}

    id: {4XNMCTBdQtk}
    title: {Will the Earths Magnetic Fields Shift?}
    description: {Is the Earth losing its magnetic field and doomed to a fate similar to Mars? Many scientists believe the answer lies in paleomagnetic data, and that this weakening may be a precursor to a magnetic field reversal.}

    id: {eHnwtkfX2k4}
    title: {The City of London, the Corporation that runs it}
    description: {A secret state within a state, with deleterious effects on democracy, politics and economics in London, the country, and the world, for the City is joint headquarters with Wall Street of global finance capital. 
    In short, 'Secret City' isn't just a film for Londoners - especially in these times of crisis, the role of the City concerns everyone everywhere.}
    
]

