Red [
    Title: "readable.crud.red"
]

.append-key-value: function[block key value /in .sub-key][

    either in [
        sub-key: to-word .sub-key
        sub-block: get-key-value block sub-key
        sub-block-new: .append-key-value sub-block value
        return change-key-value block sub-key sub-block-new
    ][
        append/only block to-set-word key
        append/only block value
        return block
    ]

]

append-key-value: :.append-key-value

.get-key-value: function[block key][
    return select block to-word key 
]

get-key-value: :.get-key-value

.change-key-value: function[block [block!] key val][
    
    index: index? find block to-word key

    next-index: index + 1
    block/:next-index: val
    return block/:next-index
]

change-key-value: :.change-key-value


.change-keys-values: function[block [block!] keys-values [block!]][

    keys: extract keys-values 2
    values: extract/index keys-values 2 2

    forall keys [
        key: keys/1
        index: index? keys
        change-key-value block key values/:index
    ]
    return block
]
change-keys-values: :.change-keys-values

;=======================================
; Examples:
;=======================================


transactions: load %transactions.read

write %test.read mold transactions

;--------------------------------------

transactions: append-key-value transactions 'T-2017.12.08-0001 [

    .SYMBOL: AAPL
    .CURRENCY: DOLLAR
    .BROKER: GOLDMAN-SACHS         

    .ACTION-ENTRY: BOUGHT
    .QTY-ENTRY: 100
    .PRICE-ENTRY: 175.95
    .DATETIME-ENTRY: 18/12/2017

]

;?? transactions

append-key-value/in transactions 'T-2017.12.08-0001 [

    .ACTION-EXIT: SOLD
    .QTY-EXIT: 177.80
    .PRICE-EXIT: 1018.07
    .DATETIME-EXIT: 19/12/2017

    .PARENT-TRANSACTION: none

    .COMMENT: {}
    .IMAGE: 
]

?? transactions

transaction: select transactions to-lit-word 'T-2017.12.07-0001
;?? transaction

test: change-key-value transaction '.ACTION-EXIT 'TEST
;?? test

change-key-value transactions 'T-2017.12.07-0001 transaction
;?? transactions

;==================

;transaction: select transactions to-lit-word 'T-2017.12.07-0001
transaction: get-key-value transactions 'T-2017.12.07-0001

change-keys-values transaction [
    .ACTION-EXIT: SOLD
    .QTY-EXIT: 800
]

change-key-value transactions 'T-2017.12.07-0001 transaction
;?? transactions

; index: index? find transaction to-lit-word '.ACTION-EXIT
; next-index: index + 1
; transaction/:next-index: 'SELL
; test: transaction/:next-index
; ?? test


; field: select transaction to-lit-word '.ACTION-EXIT
; change field 'BOUGHT
; ?? field