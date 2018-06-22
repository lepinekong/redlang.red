Red [
    Title: "embrace"
    Purpose: {

    }
    Alias: [
        
    ]
    Build: 0.0.0.0
    History-Latest: [
        0.0.0.1 {Initial build}
    ]
]

embrace: function [ >code [word! string!] >delimiters [block!] ][
    .code: form >code
    .delimiters: >delimiters
    return rejoin [.delimiters/1 .code .delimiters/2]
]