Red [
    Title: "guid.red"
    Needs: 'View
]

;do read http://redlang.red/do-trace

.create-window: function[.title [word! string!] /size .size [pair!] /no-view][

    {Example:
        win: create-window/size/no-view "Hello World" 640x480   
    }

    title: form .title

    win: compose [
        title (title)
    ]
    if size append win compose [ size (.size)]

    unless no-view [
        view layout compose win 
    ]
    return win
]

create-window: :.create-window
.window.create: :.create-window
window.create: :.create-window

.compose-window: function[.title [word! string!] /size .size [pair!]][

    {Example:
        win: compose-window/size "Hello World" 640x480       
    }
    either size [
        return .create-window/size/no-view .title .size
    ][
        return .create-window/no-view .title
    ]
]

compose-window: :.compose-window
create-layout: :.compose-window
.window.compose: :.compose-window
window.compose: :.compose-window
