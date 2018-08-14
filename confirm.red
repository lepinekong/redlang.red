Red [
    Title: ""
]

.confirm: function [>question][
    ans: ask rejoin [{Confirm} { } >question { } {("Y" = "YES"): }]
    if (ans = "Y") or (ans = "YES") [
        return true
        exit
    ]  
    return false   
]

if not value? 'confirm [
    confirm: :.confirm
]