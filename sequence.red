Red [
    Title: "sequence.red"
]

.create-sequence: function[n][
    block: copy [] repeat i n [append block i]
    return block
]

create-sequence: :.create-sequence