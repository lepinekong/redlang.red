Red [
    Title: "gui.red"
]

do read http://redlang.red/do-trace

.create-window:  function['.arg1 [word! string! pair! unset!] '.arg2 [word! string! pair! unset!] /local ][
    switch type?/word get/any '.arg1 [

        word! string! [
            title: form .arg1

            do-trace 13 [
                ?? title
            ] %gui.red
            
        ]

        pair! [
            size: .arg1
        ]        
    ]

    switch type?/word get/any '.arg2 [
        word! string! [
            title: form .arg2
        ]

        pair! [
            size: .arg2
        ] 
    ]    

    win: copy []
    

    if not none? title [
        append win 'title 
        append win title
    ]

    do-trace 42 [
        ?? win
    ] %gui.red

    if not none? size [
        append win 'size
        append win size
    ]    

    do-trace 51 [
        ?? win
    ] %gui.red

    ?? title
    ?? size
    ?? win

    view layout win
]

Create-Window: :.Create-Window

Create-Window "Hello World" ;
Create-Window 640x480 ;
Create-Window "Hello World" 640x480 ;