Red [
    Title: "read-clipboard.red"
    Description: {Fix Red-lang double space line bug}
]

unless value? '.redlang [
    do https://redlang.red
]
.redlang [call-powershell]

unless value? '.sysWrite-Clipboard [
    .sysWrite-Clipboard: :write-clipboard
    write-clipboard: function [data [string! file! url!] /local filePath][
        if url? data [
            data: to-string data
        ]
        .sysWrite-Clipboard data
    ]  
]   

unless value? '.get-clipboard [
    .get-clipboard: function [][
        powershell-command: "Get-Clipboard"
        .Call-Powershell/out/silent powershell-command

    ]    
]


unless value? 'sysread-clipboard [
    sysread-clipboard: :read-clipboard
    read-clipboard: function [][
        .get-clipboard
    ]  
]      
