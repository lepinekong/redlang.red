Red [
    Title: ""
]

.confirm: function [>question][
    ans: ask >question
    if (ans = "Y") or (ans = "YES") [
        return true
        exit
    ]  
    return false   
]

if not value? 'confirm [
    confirm: :.confirm
]