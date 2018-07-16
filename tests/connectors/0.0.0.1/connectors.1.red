Red [
    Title: "connectors.1.red"
    Needs: 'View
    Builds: [
        0.0.0.1.1 {Initial version from bpmn 0.0.0.3.7}
    ]
]

history-shapes: copy []
history-coordinates: copy []

connect-right: function ['>distance [integer! unset!]][

    >circle-radius: system/words/circle-radius

    .circle-radius: >circle-radius

    rect: init-connector

    switch type?/word get/any '>distance [

        unset! [

            last-shape: last history-shapes
            switch/default to-lit-word last-shape [
                'circle 'connect-right [.distance: space-width-in-between]
            ][
                .distance: space-width-in-between
            ]

        ]
        integer! [
            .distance: >distance
        ]
    ]

    append rect/1 compose/deep [

        'hline (.distance)
        
    ]    

    last-shape: last history-shapes
    last-coordinates: last history-coordinates

    switch/default to-lit-word last-shape [
        'circle [
            coordinates: to-coordinates/caller/no-debug reduce [  

                .x-left-corner: last-coordinates/2/1
                .y-left-corner: last-coordinates/2/2 - .circle-radius
                .x-right-corner: last-coordinates/2/1 + .distance 
                .y-right-corner: last-coordinates/2/2 - .circle-radius      

            ] [connect-right 351]            
        ]
    ][
            coordinates: to-coordinates/caller/no-debug reduce [  

                .x-left-corner: last-coordinates/2/1
                .y-left-corner: last-coordinates/2/2 - (rect-height / 2)
                .x-right-corner: last-coordinates/2/1 + .distance 
                .y-right-corner: last-coordinates/2/2 - (rect-height / 2)     

            ] [connect-right 361]          
    ]     

    
    append-history-coordinates coordinates  
    
    append-history-shapes connect-right 
    
    compose/deep [shape (rect)]
]

; dependencies

init-rectangle: function [ /round-rectangle][
    rect: copy []

    last-shape: last history-shapes
    switch/default to-lit-word last-shape [
        'circle 'connect-right [
            append rect compose/deep [['move (make pair! reduce [
                either round-rectangle [rect-rounded-angle-size][0]
                (0 - rect-height / 2)
            ])]]
        ]
    ][
        append rect compose/deep [['move (make pair! reduce [0 (0 - rect-height)])]]
    ]  
    return rect
]

init-connector: function [][
    rect: copy []

    last-shape: last history-shapes
    switch/default to-lit-word last-shape [
        'circle [
            append rect compose/deep [['move (make pair! reduce [0 (0 - 0)])]]
        ]
        'rectangle-rounded [
            append rect compose/deep [['move (make pair! reduce [(rect-width - rect-rounded-angle-size) (rect-height / 2)])]]
        ]
    ][
        append rect compose/deep [['move (make pair! reduce [rect-width (0 - rect-height / 2)])]]
    ]  
    return rect
]

append-history-shapes: function ['>shape][
    append history-shapes >shape
]

append-history-coordinates: function [>coordinates [block!]][
    append/only history-coordinates >coordinates
]

