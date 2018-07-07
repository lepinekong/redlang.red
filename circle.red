Red [
    Title: "circle.red"
    Needs: 'View
]

circle: function [ 
    /double
    /radius .radius 
    /east-position .east-position 
    /west-position .west-position
    /center-position .center-position
][
    >radius: 16
    >east-position: 100x100

    if radius [
        >radius: .radius
    ]

    if east-position [
        >east-position: .east-position
    ]

    if west-position [
        x: .west-position/1 + (2 * >radius)
        y: .west-position/2
        >east-position: make pair! reduce [x y]
    ]

    if center-position [
        x: .center-position/1 + (1 * >radius)
        y: .center-position/2
        >east-position: make pair! reduce [x y]
    ]    
    
    shape-layout: copy [[]] 
    shape-layout/1: copy [] ; must do this otherwise will append to previous content

    if double [
        append shape-layout/1 compose/deep [
            move (make pair! reduce [>east-position/1 - 2 >east-position/2]) 
            arc (make pair! reduce [>east-position/1 - 2 >east-position/2 + 1]) 
            (>radius - 2) (>radius - 2) 0 large
            
        ]        
    ]
    append shape-layout/1 compose/deep [
        move (>east-position) 
        arc (make pair! reduce [>east-position/1 >east-position/2 + 1]) 
        (>radius) (>radius) 0 large
    ]  
    compose/deep [shape (shape-layout)]

]