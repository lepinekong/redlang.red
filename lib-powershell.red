Red [
    Title: "lib-powershell.red"
]

;for remote execution
; unless value? '.string.compose [
;     github-url-entry: https://gist.github.com/lepinekong/f007c5358104f0469d8b1ea7da11650e
;     lib: get-github-url github-url-entry %.system.libraries.string.red
;     do read lib    
; ]

.to-powershell: function[.powershell-command [string! block!]][

    either block? .powershell-command [
        command: .string.compose/separator .powershell-command ";"
    ][
        command: .powershell-command
    ]

    replace/all command {\} {\\}
    replace/all command {"} {\"}
    powershell-command: rejoin [{powershell -command} { } {"} command {"}]

    return powershell-command
] 

.to.powershell: :.to-powershell
to-powershell: :.to-powershell
to.powershell: :.to-powershell

.call-powershell: function[.powershell-command /out /silent][

    powershell-command: .to-powershell .powershell-command 

    either not out [
        call powershell-command 
    ][
        output: copy ""
        do-events/no-wait

        unless silent [
            print powershell-command
        ]
        
        do-events/no-wait
        call/output powershell-command output

        unless silent [
            print output
        ]
        return output
    ]

]

call-powershell: :.Call-Powershell
