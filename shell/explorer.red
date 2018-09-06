Red [
    Title: "explorer.red"
    Note: {Moved to quickrun.red/shell}
]

; explorer: function [>folder][
;     call/wait rejoin [{start explorer } {"} >folder {"}]
; ]

explorer: function [>path][
    >path: to-local-file to-red-file form :>path
    call/wait rejoin [{explorer.exe "} >path {"}]
]
