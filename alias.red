Red [
    Title: "alias.red"
]

.alias: function [
    {define one or several alias(es) for a function name}
    '>original-function {original name - example: print}
    '>alias-functions {alias name or block of names - example: show or [show out]}
    /verbose {verbose mode}
    /_debug {debug mode for developer}
][

    original-function: to-word form >original-function

    either block? >alias-functions [
        exclude-list: copy []
        foreach alias-function >alias-functions [
            if value? alias-function [
                if _debug [
                    print [{function} rejoin [{'} alias-function] {already exists}] ; 0.0.0.1.8
                ]
                append exclude-list alias-function
            ]
        ]

        if not empty? exclude-list [
            alias-functions-list-new: copy >alias-functions
            foreach name exclude-list [
                remove find alias-functions-list-new name
            ]
            if verbose [ ; 0.0.0.1.9
                print [{list of aliases for} rejoin [{'} original-function {:}] alias-functions-list-new]
            ]
            set alias-functions-list-new get original-function
            exit
        ]
        if verbose [ ; 0.0.0.1.9
            print [{list of aliases for} original-function {:}  >alias-functions]
        ]
        set >alias-functions get original-function
    ][
        >alias-function: >alias-functions
        alias-function: to-word form >alias-function

        set alias-function get original-function       
    ]

]

.alias .alias [alias aliases]
