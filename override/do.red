Red [
    Title: "sysdo.red"
]

if not value? 'sysdo [
    sysdo: :do
    do: function [
        {Evaluates a value, returning the last evaluation result} 
        value [any-type!] 
        /expand "Expand directives before evaluation" 
        /args {If value is a script, this will set its system/script/args} 
        arg "Args passed to a script (normally a string)" 
        /next {Do next expression only, return it, update block word} 
        position [word!] "Word updated with new block position"
    ][
        main-command: copy "sysdo"
        if expand [
            main-command: rejoin [main-command "/expand"]
        ]
        if args [
            main-command: rejoin [main-command "/args"]
        ]
        if next[
            main-command: rejoin [main-command "/next"]
        ]
        command: reduce [load main-command] ; don't forget reduce otherwise bug !!!

        append command to-word 'value

        if args [
            append command to-word 'arg
        ]
        if next [
            append command to-word 'position
        ]        
        sysdo command
    ]  
]
