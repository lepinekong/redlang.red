Red [
    Title: ".system.coder.apps.redlang.red"
    Parent: ".system.coder.apps.red"
]

.Redlang.Get-Meta: function[.src [string! file! url!]][

    {Purpose: 
        Contrary to Interpreter,
        Red compiler doesn't play well with all text above Red [] 
        so we must clean all above Red [...] before compiling
    }

    ; accept:
    ; c:\test\test.red ; windows format without space
    ; "c:\test with space\test.red" ; windows format
    ; %/c/test/test.red ; red file format
    case [
        string! = type? .src [src: .src]
        (file! = type? .src) or (url! = type? .src) [
            .src: to-red-file form .src
            src: read .src
        ]
    ]

    ; Extract Red meta
    rule-meta: [
        copy meta to "Red ["
    ]   
        
    parse src rule-meta  
    return meta    
]

Redlang.Get-Meta: :.Redlang.Get-Meta

.Redlang.Get-Program: function[.src [string! file! url!] /header][

    {Purpose: 
        Contrary to Interpreter,
        Red compiler doesn't play well with all text above Red [] 
        so we must clean all above Red [...] before compiling
    }

    ; accept:
    ; c:\test\test.red ; windows format without space
    ; "c:\test with space\test.red" ; windows format
    ; %/c/test/test.red ; red file format
    case [
        string! = type? .src [src: .src]
        (file! = type? .src) or (url! = type? .src) [
            .src: to-red-file form .src
            src: read .src
        ]
    ]

    ; Extract Red program
    rule-program: [
        any [
            to "Red [" start: thru "Red ["
        ] to end
        (program: copy start)
    ]
    parse src rule-program

    either header [

        src-block: split src newline
        src-block-extract: copy []

        count: 0
        previous-count: 0
        forall src-block [
            line: src-block/1
            parse line [
                some [
                    thru "[" (count: count + 1) 
                    |
                    thru "]" (count: count - 1)
                ]
            ]  

            either (count > 0) [
                ;?? count
                append src-block-extract line
                previous-count: count
            ][
                ;?? count
                ;?? previous-count
                if (previous-count > 0) [
                    append src-block-extract line
                    probe line
                    ask "pause"
                    break
                ]
            ]

        ]

        src-extract: copy ""
        forall src-block-extract [
            line: src-block-extract/1
            append src-extract line
            append src-extract newline
        ]

        return src-extract

    ][
        return program   
    ]
    
]

Redlang.Get-Program: :.Redlang.Get-Program

.Redlang.SHA256: function['.file [word! string! file! url! unset!] /local ][


    switch/default type?/word get/any '.file [
        unset! [
            print {
                to calculate SHA256 for red script syntax possible syntax is:
                Redlang.SHA256 c:\path-without-space\test.red
                Redlang.SHA256 "c:\path with space\test.red"
            }
        ]
        word! string! file! url! [
            file: form .file
            file: to-red-file file 
            src: read file 

            rule-meta: [
                copy meta to "Red ["
            ]   

            parse src rule-meta  

            if find meta "SHA256: " [
                parse meta [thru "SHA256: " copy SHA256 thru "^}"]
                print rejoin["Previous: " SHA256] 
            ]

            program: Redlang.get-program src
            last-SHA256: checksum program 'SHA256
            print rejoin["Last: " mold last-SHA256] 
        ]
    ][
        throw error 'script 'expect-arg .file
    ]
]

Redlang.SHA256: :.Redlang.SHA256