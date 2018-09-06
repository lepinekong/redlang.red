Red [
    Title: ""
]

.remove-last: function [
    {Example: 
        block: [1 2 3 4]
        test: remove-last block
        ?? test
    }
    >block [block!]
][
    head remove (back tail >block)
]

remove-last: :.remove-last