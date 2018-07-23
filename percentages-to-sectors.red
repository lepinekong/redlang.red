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

percentages-colors-to-sectors: function [
    percentages-colors
    /with-labels
][

    ; percentages-colors: [
    ;     30.6 61.160.255
    ;     19.4 99.212.212
    ;     11.1 80.202.115
    ;     11.1 250.212.57
    ;     13.9 242.97.123
    ;     13.9 150.90.228
    ; ]

    percentages: extract percentages-colors 2
    ?? percentages

    percentages-sectors: percentages-to-sectors percentages

    sectors: copy []

    forall percentages-sectors [
        i: index? percentages-sectors
        sector: percentages-sectors/1
        color: pick percentages-colors (i * 2)

        either with-labels [
            append/only sectors reduce [
                to-set-word 'angles sector
                to-set-word 'color color
            ]
        ][
            append/only sectors reduce [
                sector
                color
            ]
        ]
    ]

    return sectors
]
