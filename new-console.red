Red [
    Title: "new-console.red"
    Stable: "YES"
]

.new-console: function[
    /script 'param>script
    /colors param>colors
    /_debug
][

    red-path: to-local-file system/options/boot
    cmd: rejoin [{start "" } {"} red-path {"}] 
    local>colors-string: {colors: [14.16.26 211.54.130]}

    if error? try [
        load-thru/update https://redlang.red/console-script.red
    ][
        ;TODO: if _debug
    ]

    local>console-script-path: path-thru https://redlang.red/console-script.red

    unless not exists? local>console-script-path [
        cmd: rejoin [
            cmd { } 
            {"} (to-local-file local>console-script-path)  {"}

        ] 
    ]
   
    if script [

        cmd: rejoin [

            cmd

            { }
            {"} (form :param>script) {"} ; ex: https://redlang.red

            ; if colors
            { }
            {"}
            {[}
            (local>colors-string)
            {]}
            {"}
        ]
    ]

    print cmd
    call (cmd)
]

new-console: :.new-console
