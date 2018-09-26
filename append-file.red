Red [
    Title: ""
]

.append-file: function [>out-file >content][
    write/lines/append >out-file >content
]

append-file: :.append-file

