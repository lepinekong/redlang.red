Red [
    Title: "log.red"
]

.log: function ['>log-file >msg /separator >separator][

    unless separator [
        >separator: {-}
    ]
    .log-file: to-red-file :>log-file
    .msg: form :>msg
    .msg: rejoin [now " " >separator " ".msg]
    write/lines/append .log-file .msg
]
log: :.log
