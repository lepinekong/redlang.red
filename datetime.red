Red [
    Title: "DateTime"
    Origin: ".system.libraries.datetime.red"
]

.time: function[
    /hour
    /minute
    /second
][
    time: now/time
    if hour [
        return pad-left time/hour 2
    ]
    if minute [
        return pad-left time/minute 2
    ]
    if second [
        round/to
        return pad-left (round/to (time/second) 1) 2
    ]
]

time: :.time

.get-string-date: function [][

    year: pad-left now/year 2
    month: pad-left now/month 2
    day: pad-left now/day 2

    hour: time/hour
    minute: time/minute
    second: time/second

    return rejoin reduce [year "." month "." day "_" hour "." minute "." second]
]

get-string-date: :.get-string-date