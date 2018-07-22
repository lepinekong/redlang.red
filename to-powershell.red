Red [
    Title: "to-powershell.red"
]

.to-powershell: function[.powershell-command [string! block!]][

    either block? .powershell-command [

        if not value? '.string.compose [
            do https://redlang.red/string-compose
        ]
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