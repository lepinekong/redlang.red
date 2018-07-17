Red [
    Title: "powershell-lib.red"
]

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