Red [
    Title: "sum.red"
]

.sum: function [
    {Usage: sums a block
    Example:
        sum [10 20 30 40]
    }
    >block [block!]
][

    sum: 0
    forall >block [
        element: >block/1
        sum: sum + element
    ]
    return sum
]

sum: :.sum

