Red [
    Title: ""
]

if not value? '.redlang [
    do https://redlang.red
]
.redlang [call-powershell]

.rename-file: function [>file-path][
    >local-file-path: to-local-file >file-path
    call-powershell/out rejoin [{Rename-Item} { } >local-file-path] 
]