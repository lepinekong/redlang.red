Red [
    Title: "get-console-type.red"
]

.get-console-type: function [][

    either (system/console = none) [ 
        ; for compiled version (no console)
        return none
    ][ 
        either system/console/gui? [
            ; for interpreted version with gui console
            return 'gui-console
        ][
            ; for interpreted version with non-gui console (vscode)
            return 'non-gui-console
        ]

    ]     
]

get-console-type: :.get-console-type