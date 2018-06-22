Red [
    Title: "block-to-string"
    Purpose: {

    }
    Alias: [
        
    ]
    Build: 0.0.0.2
    History-Latest: [
        0.0.0.2 {form block/1}
        0.0.0.1 {Initial build}
    ]
]

.block-to-string: function [/block >block /delimiter >delimiter][

    {Example:
        r: .block-to-string/block/delimiter [a b] ","
        ? r
    }

    .block: >block
    .delimiter: >delimiter

    n: length? .block
    cum: collect [
        forall .block [
            i: index? .block
            either i < n [
                keep rejoin [form .block/1 .delimiter]
            ][
                keep form .block/1
            ]
        ]
    ]

    return rejoin cum
]

block-to-string: :.block-to-string
