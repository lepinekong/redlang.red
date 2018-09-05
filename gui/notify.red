Red [
    Title: ""
]

notify: func [>message][
    view/flags [
        text center middle >message rate 0:0:3 on-time [unview self]
    ] 'no-title
]


