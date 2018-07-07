Red [
    Title: "margin.red"
    Needs: 'View
]

margin: function ['.margin-value [integer! unset!]][

    switch type?/word get/any '.margin-value [
        unset! [
            left-margin-value: 100
            right-margin-value: 50
        ]
        integer! [

            left-margin-value: .margin-value
            right-margin-value: .margin-value
        ]
    ]

    shape-layout: copy [[]] 
    shape-layout/1: copy [] ; must do this otherwise will append to previous content

    append shape-layout/1 compose/deep [
        ;'move 100x100  ; left-margin = right-margin
        'move (make pair! reduce [left-margin-value right-margin-value])
    ]    
    compose/deep [shape (shape-layout)]
]