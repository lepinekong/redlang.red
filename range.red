Red [
    Title: "range.red"
    Builds: [
        0.0.0.2 {/random/part refinements}
        0.0.0.1 {Initial build}
    ]
]



.range: function[>min >max /random /dices n [integer!]][
    sysRandom: :system/words/random
    min: >min
    max: >max
    block: collect [repeat i (>max - min + 1) [keep (i + min - 1)]]  
    randomize: function[block][
        sysRandom/seed now/time
        block: sysRandom block
    ]
    if random [
        block: randomize block      
    ]
    if dices [
        .dices: copy []
        repeat i n [
            append .dices first randomize block
        ]
        return .dices
    ]      
    return block
]
range: :.range

;usage examples:
;probe range/random 1 6 ; [5 6 3 1 2 4]
;probe range/dices 1 6 2 ; [5 2]