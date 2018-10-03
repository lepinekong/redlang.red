Red [
    Title: ""
]

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