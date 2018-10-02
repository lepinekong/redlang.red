Red [
    Title: ""
    Comment: {
        cloned from code.split.red
    }
]

if not value? '.redlang [
    do https://redlang.red
]

.redlang [alias]

.Get-Red-Meta-Header: function[
    .src [string! file! url!]
][

    {Purpose: 
        Contrary to Interpreter,
        Red compiler doesn't play well with all text above Red [] 
        so we must clean all above Red [...] before compiling
        accept:
        c:\test\test.red ; windows format without space
        "c:\test with space\test.red" ; windows format
        %/c/test/test.red ; red file format        
    }

    case [
        string! = type? .src [src: .src]
        (file! = type? .src) or (url! = type? .src) [
            .src: to-red-file form .src
            src: read .src
        ]
    ]

    ; Extract Red Header
    rule-meta: [
        copy meta to "Red ["
    ]   
        
    parse src rule-meta  
    return meta    
]

.alias .Get-Red-Meta-Header [
    .Get-Red-Meta
    Redlang.Get-Meta 
    .Redlang.Get-Meta 
]

