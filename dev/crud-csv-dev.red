Red [
    Title: "crud-csv.red"
    Alias: [
        crud-csv
    ]
]

read-csv: function[data-file][

    if not exists? data-file [
        print rejoin [data-file " doesn't exist."]
        return false
    ]

    lines: skip Read/lines data-file 1 ; skip first csv header line 
    records: copy []

    forall lines [
        append/only records split lines/1 ","
    ]
    return records
]


save-csv: function[records data-file][
    write/lines file-path lines
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



