Red [
    Title: ""
]

.split-red-source: function [
    '>source-file 
    /to-string ; returns string format otherwise returns block
][

    source-file: to-red-file form >source-file

    source: load source-file

    header: reduce ['Red select source 'Red]
    body: remove remove (copy source) 

    either to-string [
        return reduce [(mold/only header) (mold/only body)]
    ][
        return reduce [header body]
    ]
    
]
split-red-source: :.split-red-source



