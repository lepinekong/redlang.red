Red [
    Title: ""
]


.Read: function [
    "Reads from a file, URL, or other port" 
    source [file! url! string! unset!] 
    /part {Partial read a given number of units (source relative)} 
    length [number!] 
    /seek "Read from a specific position (source relative)" 
    index [number!] 
    /binary "Preserves contents exactly" 
    /clipboard "Read from clipboard"
    /lines "Convert to block of strings" 
    /info 
    /as {Read with the specified encoding, default is 'UTF-8} 
    encoding [word!]
    /local 
    source?
    out
][


    bin-to-string: function [bin [binary!]][
        text: make string! length? bin
        foreach byte bin [append text to char! byte]
        text
    ] 
    
    source?: true

    switch/default type?/word get/any 'source [
    unset! [
        if clipboard [
            source: read-clipboard
            source?: false
        ]
    ]
    url! [
        response: write/binary/info source [GET [User-Agent: "Red 0.6.3"]]
        out: bin-to-string response/3
    ]
    ][

        either lines [
            if (suffix? source) = %.zip [
                return ""
            ]
            switch/default (type?/word source) [
                file! url! [
                    out: sysRead/lines source
                ]
                string! [
                    out: split source newline
                ]
            ][
                out: sysRead/lines source
            ]
        ][
            ; prevent error when reading path not terminated with /
            if exists? source [
                if error? try [
                    out: sysRead source
                ][
                    if (last source) <> #"/" [
                        source: rejoin [source #"/"]
                        out: sysRead source
                    ]
                ]
            ]
        ] 
    ]

    either source? [
        either clipboard [
        ][
            out
        ]
    ][
        out
    ]
]