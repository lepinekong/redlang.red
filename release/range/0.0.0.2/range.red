Red [
    Title: "range.red"
    Builds: [
        0.0.0.2 {/random/part refinements}
        0.0.0.1 {Initial build}
    ]
]

.range: function[>min >max /random /part n [integer!]][
    sysRandom: :system/words/random
    min: >min
    max: >max
    block: collect [repeat i (>max - min + 1) [keep (i + min - 1)]]  
    if random [
        sysRandom/seed now/time
        block: sysRandom block
    ]
    if part [
        block: copy/part block n
    ]
    return block
]
range: :.range

;usage example:
;probe range/random/part 1 6 2