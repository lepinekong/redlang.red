Red [
    Title: ""
    .links: [
        
    ]
    Builds: [
        0.0.0.1.1 [
            6 {counter}
        ]
    ]
]

unless value? 'do-trace [
    do http://redlang.red/do-trace
]

unless value? '.console [
    .console: context [
        set-background: function [
            param>background-color
            /local static>counter
            /_build
        ][

            static>counter: []
            either empty? static>counter [
                append static>counter 1
            ][
                static>counter/1: static>counter/1 + 1
            ]

            param>font-color: white

            palette>colors: [
                100.99.143 ; https://htmlcolors.com/hex/64638F mauve
                62.88.75 ; https://htmlcolors.com/hex/3E584B kaki
                124.25.13 ; https://htmlcolors.com/hex/7C190D sang
                21.12.20 ; https://htmlcolors.com/hex/150C14 marron-noir
            ]
            n: length? (palette>colors)
            ;random/seed n ; 0.0.0.1.1.7: BUG !!!
            ;p: random/only n ; 0.0.0.1.1.7: STILL BUG !!!
            p: random n
            
            do-trace 44 [
                ?? n
                ?? p ; BUG ???? always 1
            ] %console-script.9.red
            
            if param>background-color = 'random [
                param>background-color: pick palette>colors (p)
            ]
            gui-console-ctx/set-background (param>background-color)
            gui-console-ctx/set-font-color (param>font-color)
        ]
    ]
]

unless value? 'console [
    console: .console
]

.console-ctx: context [

    block-args: system/options/args
    args: system/script/args

    .console/set-background 'random

    ..do-script-arg: function [][
        unless none?  block-args [
            if find script: block-args/1 "http" [
                script: to-url script
                do script
            ]
        ]
    ]  

    ..do-script-arg

]
