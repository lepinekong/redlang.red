Red [
    Title: ""
]

.pad-number: function [>number /length >length][

    unless length [
        >length: 2
    ]
    
    pad/left/with >number >length #"0"
]

pad-number: :.pad-number
