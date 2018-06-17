Red [
    Title: "crud-csv.red"
    Alias: [
        crud-csv
    ]
    Build: 1.0.1.0
    History-Latest: [
        1.0.0.1 {First version}
        1.0.0.2 {Optionally return a header for read-csv}
        1.0.0.3 {Optionally return flat records with header for read-csv}
        1.0.0.5 {Start fixing save-csv when header arg is a block instead of a delimited comma string}
        1.0.0.8 {End fixing save-csv when header arg is a block instead of a delimited comma string}
        1.0.0.9 {add-csv : +case not block? +records-or-file}
    ]
]

.read-csv: function[data-file /header /flat /delimiter +delimiter][

    either delimiter [
        -delimiter: +delimiter
    ][
        -delimiter: ","
    ]

    if not exists? data-file [
        print rejoin [data-file " doesn't exist."]
        return false
    ]

    lines: skip (all-lines: Read/lines data-file) 1 ; skip first csv header line 
    records: copy []

    forall lines [
        append/only records split lines/1 -delimiter
    ]

    either not header [
        return records
    ]
    ;--------------------- for header ------------------------------    
    [
        header: split (first all-lines) -delimiter
        unless flat [
            return append [] compose/only [ (header) (records)]
        ]
        return append [] compose [ (header) (records)]
    ]
    
]

read-csv: :.read-csv

.save-csv: function[+data-file +records /header +header][

    if block? +data-file [
        file: +records
        +records: +data-file
        +data-file: file
    ]

    -whole-records: copy []
    if header [
        
        either block? +header [
            -header: block-to-csv-line +header
        ][
            -header: +header
        ]
        append -whole-records -header     
    ]
    
    forall +records [
        append -whole-records block-to-csv-line +records/1
    ]  

    write/lines +data-file -whole-records
] 

save-csv: :.save-csv

.add-csv-record: function[+records [block!] +record [block! string!]][

    either not block? +record [
        -record: split +record ","
    ][
        -record: +record
    ]

    append/only +records +record
    return +records

]

add-csv-record: :.add-csv-record

.add-csv: function[+records-or-file [block! file!] record [block! string!]][

    either not block? +records-or-file [
        ;file case
        -data-file: +records-or-file
        -records: read-csv -data-file
    ][
        -records: +records-or-file
    ]

    if not block? record [
        record: split record ","
    ]

    append/only -records record

    if not block? +records-or-file [
        ;file case
        save-csv -data-file records
    ]
    return records

]

add-csv: :.add-csv
add-csv-file: :.add-csv

search-csv: function[records searched-value][

    records-numbers: copy []

    forall records [
        record: records/1 
        i: index? records

        forall record [
            field-value: record/1
            if not none? find field-value searched-value [
                append records-numbers i
                break
            ]
        ]
    ]
    
    return records-numbers
]

update-csv: function[records record-number record][

    if (record-number > 1) [
        repeat i (record-number - 1) [
            records: next records
        ]
    ]
    change/only records record
    records: head records
    return records
]

delete-csv: function[records record-number-or-search-string][

    record-number: record-number-or-search-string

    if string? record-number-or-search-string [
        records-numbers: search-csv records record-number-or-search-string
        record-number: records-numbers/1
    ]

    if (record-number > 1) [
        repeat i (record-number - 1) [
            records: next records
        ]
    ]
    
    remove records
    records: head records

    return records
]

;============================= utilities functions ====================================

.block-to-comma-delimited-string: function[.block [block!] /delimiter .delimiter][
    delimited-string: copy ""
    n: length? .block

    unless delimiter [
        .delimiter: ","
    ]

    forall .block [
        element: .block/1
        i: index? .block
        
        either i < n [
            delimited-string: rejoin [delimited-string element .delimiter]
        ][
            delimited-string: rejoin [delimited-string element]
        ]
    ]
]

block-to-comma-delimited-string: :.block-to-comma-delimited-string
block-to-csv-line: :.block-to-comma-delimited-string


