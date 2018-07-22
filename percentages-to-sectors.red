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
][

    .sectors: copy []
    unless start-angle [
        >start-angle: -90
    ]

    start-angle: >start-angle
    foreach percentage >percentages [
        append .sectors reduce [
            percentage
            as-pair start-angle sweep-angle: (percentage * 360.0 / 100)
        ]
        start-angle: start-angle + sweep-angle
    ]
    return .sectors
]

