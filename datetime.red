Red [
    Title: "DateTime"
    Origin: ".system.libraries.datetime.red"
]

.today: function [/to-string][
    unless to-string [return now]
    return .get-string-date now
]
today: :.today

.get-string-date: function [>the-date /separator >separator][

    unless separator [
        >separator: "."
    ]

    year: pad-left >the-date/year 2
    month: pad-left >the-date/month 2
    day: pad-left >the-date/day 2    

    ; hour: pad-left >the-date/time/hour 2
    ; minute: pad-left >the-date/time/minute 2
    ; second: pad-left >the-date/time/second 2

    hms: .get-string-time/separator >the-date/time >separator

    ;return rejoin reduce [year "." month "." day "_" hour "." minute "." second]
    return rejoin reduce [year >separator month >separator day "_" hms]
]

get-string-date: :.get-string-date
get-date-string: :.get-string-date

.get-string-time: function [>the-time /hour /minute /second /separator >separator][

    unless separator [
        >separator: "."
    ]
    hours: pad-left >the-time/hour 2
    if hour [return hours]
    minutes: pad-left >the-time/minute 2
    if minute [
        either hour [
            return rejoin reduce [hours >separator minutes]
        ][
            return minutes
        ]
    ]
    seconds: pad-left >the-time/second 2    
    if second [
        either hour [
            return rejoin reduce [hours >separator minutes >separator seconds]
        ][
            either minute [
                return rejoin reduce [minutes >separator seconds]
            ][
                return seconds
            ]
            
        ]
    ]    

    return rejoin reduce [hours >separator minutes >separator seconds]

    ; if hour [
    ;     return pad-left time/hour 2
    ; ]
    ; if minute [
    ;     return pad-left time/minute 2
    ; ]
    ; if second [
    ;     round/to
    ;     return pad-left (round/to (time/second) 1) 2
    ; ]
]

get-string-time: :.get-string-time
get-time-string: :.get-string-time
