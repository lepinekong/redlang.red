Red [
    Title: "log.red"
]

.log: function ['>log-file >msg][

    .log-file: to-red-file :>log-file
    .msg: form :>msg
    .msg: rejoin [now { - } .msg]
    write/lines/append .log-file .msg
]
log: :.log