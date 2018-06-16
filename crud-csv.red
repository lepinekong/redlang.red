Red [
    Title: "crud-csv.red"
    Alias: [
        crud-csv
    ]
    Build: 1.0.0.6
    History-Latest: [
        1.0.0.1 {First version}
        1.0.0.2 {Optionally return a header for read-csv}
        1.0.0.3 {Optionally return flat records with header for read-csv}
        1.0.0.5 {Start fixing save-csv when header arg is a block instead of a delimited comma string}
    ]
]

read-csv: function[data-file /header /flat][

    if not exists? data-file [
        print rejoin [data-file " doesn't exist."]
        return false
    ]

    lines: skip (all-lines: Read/lines data-file) 1 ; skip first csv header line 
    records: copy []

    forall lines [
        append/only records split lines/1 ","
    ]

    either not header [
        return records
    ]
    ;--------------------- for header ------------------------------    
    [
        header: split (first all-lines) ","
        unless flat [
            return append [] compose/only [ (header) (records)]
        ]
        return append [] compose [ (header) (records)]
    ]
    
]


save-csv: function[records data-file /header .header][

    whole-records: copy []
    if header [
        if block? header [

        ]
        append whole-records .header
    ]
    append whole-records records
    write/lines data-file whole-records
]

add-csv: function[records record][
    {
        Example:
        add-csv {05/07/2018,05/07/2020,Tablette Windows 10,Microsoft - SURFACE PRO I5 256GB,1,1376.55€,DARTY LES HALLES 907037 / 9543295,to repair}
    }
    if not block? record [
        record: split record ","
    ]

    append/only records record
    return records
]

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

.block-to-comma-delimited-string: function[.block [block!] /separator .separator][
    delimited-string: copy ""
    n: length? .block

    unless separator [
        .separator: ","
    ]

    forall .block [
        element: .block/1
        i: index? .block
        
        either i < n [
            delimited-string: rejoin [delimited-string element .separator]
        ][
            delimited-string: rejoin [delimited-string element]
        ]
    ]
]

block-to-comma-delimited-string: :.block-to-comma-delimited-string
block-to-csv-line: :.block-to-comma-delimited-string


