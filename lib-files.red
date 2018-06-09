Red [
    Title: "lib-files.red"
    In: [
        %authoring.red
    ]
]

.get-short-filename: function[.filepath [file! url!] /wo-extension /without-extension][

    filepath: .filepath
    short-filename: (pick (split-path .filepath) 2)
    unless (without-extension or wo-extension) [
        return short-filename
    ]
    return (pick (.split-filename short-filename) 1)
    
]

get-short-filename: :.get-short-filename

.split-filename: function[.filename][

    {
        #### Example:
            .split-filename short-filename
    }
    ;example -> .filename: %/c/test/test.red
    filename: reverse copy .filename
    pos: index? find filename "."
    suffix: reverse (copy/part filename pos)
    short-filename: copy/part (reverse filename) ((length? filename) - (length? suffix))
    return reduce [short-filename suffix]
]

split-filename: :.split-filename

.get-file-extension: function[.filepath [file! url!]][
    short-filename: .get-short-filename .filepath 
    return pick (.split-filename short-filename) 2
]

get-file-extension: :.get-file-extension

.to-file: function [.file [file! string! word! block!]][

    either block? .file [
        return to-red-file rejoin .file
    ][
        return to-red-file form .file
    ]
    
]  

to-file: :.to-file

.to-dir:  function[.dir [word! string! file! url! block! unset!] /local ][

	{

        #### Example:
        - [x] [0]. to-dir %/c/test/ -> %/c/test/
        - [x] [1]. to-dir %/c/test -> %/c/test/
        - [X] [2]. to-dir c:\test -> %/c/test/

    }

    switch/default type?/word .dir [
        unset! [
            print {TODO:}
        ]
        file! [
            dir: :.dir
            if not dir? dir [
                append dir to-string "/"
                to-red-file dir            
            ]
            dir
        ]
        word! string! url! [
            dir: to-red-file to-string :.dir
            replace/all dir "//" "/"         
            to-dir (dir)
        ]
        block! [
            dir: .dir
            joined-dir: copy ""
            forall dir [
                append joined-dir rejoin [dir/1 "/"]
            ]
            repeat i 2 [replace/all joined-dir "//" "/"]
            to-red-file joined-dir
        ]
    ] [
        throw error 'script 'expect-arg varName
    ]
]

to-dir: :.to-dir
