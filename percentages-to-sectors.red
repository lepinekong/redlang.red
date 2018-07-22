Red [
    Title: "percentages-to-sectors.red"
]

percentages-to-sectors: function [

    {Convert percentages into sectors angles for draw
    Example: 
    percentages-to-sectors [
        30.6
        19.4
        11.1
        11.1
        13.9 
        13.9
    ]
    }
    
    >percentages /start-angle >start-angle
    /keep-percentage
    /format-in-block
][

    .sectors: copy []
    unless start-angle [
        >start-angle: -90
    ]

    start-angle: >start-angle
    foreach percentage >percentages [
        sector: copy []

        if keep-percentage [
            append sector percentage
        ] 
        append sector reduce [
            as-pair start-angle sweep-angle: (percentage * 360.0 / 100)
        ]
        either format-in-block [
            append/only .sectors sector
        ][
            append .sectors sector
        ]

        start-angle: start-angle + sweep-angle
    ]
    return .sectors
]

