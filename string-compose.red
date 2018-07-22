Red [
    Title: "string-compose.red"
]

.string.compose: function [.string-block [block!] /separator .separator][

	{

        #### Example:
        - [x] [1]. .string.compose ["a" "b" "c"]     
    }

    string-block: copy []
    
    either separator [
        append string-block .string-block/1
        foreach string skip .string-block 1 [
            append string-block .separator
            append string-block string
        ]
    ][
        string-block: copy .string-block  
    ]
    return rejoin compose string-block
]

string.compose: :.string.compose
compose-string: :string.compose
concatenate-string: :string.compose
