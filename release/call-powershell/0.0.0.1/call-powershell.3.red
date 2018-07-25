Red [
    Title: "call-powershell.red"
    Builds: [
        0.0.0.1.3 {Initial version}
    ]   
]

.call-powershell: function[.powershell-command /out /silent][

    unless value? '.to-powershell [
        do https://redlang.red/to-powershell.red
    ]

    powershell-command: .to-powershell .powershell-command 
    print powershell-command

    either not out [
        call powershell-command 
    ][
        output: copy ""

        unless value? '.do-events [
            do https://redlang.red/do-events.red
        ]

        .do-events/no-wait

        unless silent [
            print powershell-command
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