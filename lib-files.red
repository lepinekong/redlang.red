Red [
    Title: "lib-files.red"
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
