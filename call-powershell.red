Red [
    Title: "call-powershell.red"
    Builds: [
        0.0.0.1.3 {Initial version}
    ]   
    Iterations: [
        4 {Refactoring of unless value? '.to-powershell
        commenting:
        ; unless silent [
        ;     print powershell-command
        ; ]        
        }
    ]
]

.call-powershell: function[
    .powershell-command 
        /out /silent
        /_build
        /_debug
    ][

    unless value? '.to-powershell [
        if error? try [
            do load-thru/update https://redlang.red/to-powershell.red
        ][
            if error? try [
                do load-thru https://redlang.red/to-powershell.red
                print "internet connection error, loaded from cache"
            ][
                print "internet connection error, cannot load from cache"
            ]

        ]
    ]

    if _build [
        Builds: [
            0.0.0.1.5 {Debug message}
        ]  
    ]

    if _debug [
        do https://redlang.red/do-trace
    ]

    if _debug [
        do-trace 41 [
            ?? .powershell-command 
        ] %call-powershell.5.red
    ]

    powershell-command: .to-powershell .powershell-command 
    ;print powershell-command

    if _debug [
        do-trace 43 [
            ?? powershell-command
        ] %call-powershell.5.red
        
    ]    

    either not out [
        call powershell-command 
    ][
        output: copy ""

        unless value? '.do-events [
            do https://redlang.red/do-events.red
        ]
        
        .do-events/no-wait
        call/output powershell-command output

        unless silent [
            print output
        ]
        return output
    ]

]

call-powershell: :.Call-Powershell