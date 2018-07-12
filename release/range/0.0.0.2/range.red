Red [
    Title: "range.red"
    Builds: [
        0.0.0.2 {/random refinement}
        0.0.0.1 {Initial build}
    ]
]

.range: function[>min >max /random][
    sysRandom: :system/words/random
    min: >min
    max: >max
    block: collect [repeat i (>max - min + 1) [keep (i + min - 1)]]  
    if random [
        sysRandom/seed now/time
        block: sysRandom block
    ]
    return block
]
range: :.range