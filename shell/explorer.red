Red [
    Title: "explorer.red"
]

; explorer: function [>folder][
;     call/wait rejoin [{start explorer } {"} >folder {"}]
; ]

explorer: function [>path][
    >path: to-local-file to-red-file form :>path
    call/wait rejoin [{explorer.exe "} >path {"}]
]
