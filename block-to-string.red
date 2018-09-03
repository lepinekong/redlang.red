Red [
    Title: "block-to-string"
    Purpose: {

    }
    Alias: [
        
    ]
    Build: 0.0.0.2.1
    History-Latest: [
        0.0.0.2.2 {Do: fix error with empty block passed}
        0.0.0.2 {form block/1}
        0.0.0.1 {Initial build}
    ]

    Notes: [
        >1: {
            do-trace 49 ?? out for block-to-string [] ","
            ->
            []
            weird would think "" instead
        }
    ]
]

.block-to-string: function [/block >block /delimiter >delimiter][

    {Example:
        r: .block-to-string/block/delimiter ["a" "b"] ","
        ? r
    }

    .block: >block
    .delimiter: >delimiter

    n: length? .block
    cum: collect [
        forall .block [

            either .block = (back tail .block) [
              keep form .block/1  
            ][
              keep rejoin [form .block/1 .delimiter]
            ]
        ]
    ]

    out: rejoin cum 

    return out
]

block-to-string: function[>block >delimiter][
    .block-to-string/block/delimiter >block >delimiter
]

