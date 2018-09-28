Red [
    Title: "get-block-content.red"
    Note: {used by save-readable.red}
]

.get-block-content: function [>block][
    lines: .read/lines mold >block
    lines: skip lines 1

    remove-last lines

    forall lines [
        line: lines/1
        parse line [thru "    " copy line to end]
        append out line
        append out newline
    ]
    return out
]

get-block-content: :.get-block-content
