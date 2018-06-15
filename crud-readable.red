Red [
    Title: "crud-readable.red"
]

.Read-ReAdABLE: function [.ReAdABLE-path][

    {Example: 
        transactions: read-readable %db/trading-journal.read 
    }

    return transactions: load .ReAdABLE-path
]

Read-ReAdABLE: :.Read-ReAdABLE

Add-ReAdABLE: function[.readable-source [file! url! block!] .key [word!] .value][

    {Example:
        T-2017.12.08-0001: [

            .SYMBOL: AAPL
            .CURRENCY: DOLLAR
            .BROKER: GOLDMAN-SACHS         

            .ACTION-ENTRY: BOUGHT
            .QTY-ENTRY: 100
            .PRICE-ENTRY: 175.95
            .DATETIME-ENTRY: 18/12/2017

        ] 

        transactions: %db/trading-journal.read 
        add-readable transactions 'T-2017.12.08-0001 T-2017.12.08-0001
    }

    either not block? .readable-source [
        readable-block: .read-readable .readable-source
    ][
        readable-block: .readable-source
    ]

    .append-key-value: function[.block [block!] .key [word!] .value][

            append/only block to-set-word key
            append/only block value
            return block
    ] 

    return .append-key-value readable-block .key .value

]



.change-key-value: function[.block [block!] .key val][

    block: copy .block
    
    key: form .key
    MULTI-KEYS?: (find key "/")
    if MULTI-KEYS? [

        keys: split key "/"

        count: length? keys
        reverse-keys: reverse copy keys      
            
        forall reverse-keys [

            index: index? reverse-keys

            LAST-KEY?: (index >= count)
            if NOT LAST-KEY? [
                key: reverse-keys/1
                next-key: reverse-keys/2

                either count >= 3 [
                    
                    either (count - index) >= 2 [
                        
                        next-next-key: reverse-keys/3
                        block: select block to-word next-next-key

                    ][
                        
                        block: copy .block

                        
                    ]
                ][
                    block: copy .block
                ]

                target-block: select block to-word next-key
                target-block: .change-key-value target-block to-word key val
                val: copy target-block

            ]
        ]

        block: .change-key-value block to-word next-key target-block

        return block 
    ]
    
    index: index? find block to-word key

    next-index: index + 1
    block/:next-index: val

    return block
] 
