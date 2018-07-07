Red [
    Title: "rectangles.red"
    Needs: 'View
    Build: [
        0.0.0.1.11 {Initial version}
    ]
]

do read https://redlang.red/margin

rectangle: function [/rounded /inverted][

    shape-layout: copy [[]] 
    shape-layout/1: copy [] ; must do this otherwise will append to previous content

    either rounded [

        angle-size: 5.0
        rect-rounded-width: 100 - (2 * angle-size)
        rect-rounded-height: 50 - (2 * angle-size) 

        either inverted [
            angles: compose [
                (make pair! reduce [angle-size angle-size]) ; 5x5
                (make pair! reduce [0 - angle-size angle-size]) ;-5x5
                (make pair! reduce [0 - angle-size 0 - angle-size]) ;-5x-5
                (make pair! reduce [angle-size 0 - angle-size]) ;5x-5
            ]            

            append shape-layout/1 compose/deep [
                'move (make pair! reduce [angle-size 0]) ; to adjust pen position for next shape
                'hline (rect-rounded-width)
                'arc (angles/1) (angle-size) (angle-size) (rect-rounded-width) ; no sweep for negative angle
                'vline (rect-rounded-height)
                'arc (angles/2) (angle-size) (angle-size)  (rect-rounded-width)         
                'hline (0 - rect-rounded-width)
                'arc (angles/3) (angle-size) (angle-size) (rect-rounded-width)  
                'vline (0 - rect-rounded-height)
                'arc (angles/4) (angle-size) (angle-size)  (rect-rounded-width) 
                'move (make pair! reduce [0 - angle-size 0]) ; no sweep for negative angle
            ]

        ][

            angles: compose [
                (make pair! reduce [angle-size angle-size]) ; 5x5
                (make pair! reduce [0 - angle-size angle-size]) ;-5x5
                (make pair! reduce [0 - angle-size 0 - angle-size]) ;-5x-5
                (make pair! reduce [angle-size 0 - angle-size]) ;5x-5
            ]            

            append shape-layout/1 compose/deep [
                'move (make pair! reduce [angle-size 0]) ; to adjust pen position for next shape
                'hline (rect-rounded-width)
                'arc (angles/1) (angle-size) (angle-size) (rect-rounded-width) sweep ; sweep needed for positive angle
                'vline (rect-rounded-height)
                'arc (angles/2) (angle-size) (angle-size)  (rect-rounded-width) sweep         
                'hline (0 - rect-rounded-width)
                'arc (angles/3) (angle-size) (angle-size) (rect-rounded-width) sweep   
                'vline (0 - rect-rounded-height)
                'arc (angles/4) (angle-size) (angle-size)  (rect-rounded-width) sweep  
                'move (make pair! reduce [0 - angle-size 0]) ; to adjust pen position for next shape
            ]
        ]
    ][
        append shape-layout/1 compose/deep [
            'hline 100
            'vline 50
            'hline -100
            'vline -50
        ]
    ]

    compose/deep [shape (shape-layout)]

]


