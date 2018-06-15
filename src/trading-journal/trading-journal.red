Red [
    Title: "trading-journal.red"
    demo: {do read http://redlang.red/src/trading-journal.red}
]

do read http://redlang.red/do-trace.red

do read http://redlang.red/crud-readable.red

data-file: %db/trading-journal.read
if not exists? data-file [
    make-dir %db
    write data-file read http://redlang.red/src/trading-journal/db/trading-journal.read
    print rejoin ["Created " clean-path data-file]
]

transactions: read-readable %db/trading-journal.read

transactions: Add-Readable transactions 'T-2017.12.08-0001 [

    .SYMBOL: AAPL
    .CURRENCY: DOLLAR
    .BROKER: GOLDMAN-SACHS         

    .ACTION-ENTRY: BOUGHT
    .QTY-ENTRY: 100
    .PRICE-ENTRY: 175.95
    .DATETIME-ENTRY: 18/12/2017

]


do-trace 33 [
    ?? transactions
] %trading-journal.red


transactions: Update-Readable transactions 'T-2017.12.08-0001 [
    .SYMBOL: AAPL
    .CURRENCY: DOLLAR
    .BROKER: GOLDMAN-SACHS
    .ACTION-ENTRY: BOUGHT
    .QTY-ENTRY: 100
    .PRICE-ENTRY: 175.95
    .DATETIME-ENTRY: 18-Dec-2017/14:23:45
    .NOTES: [
        NOTE1: {NOTE 1}
        NOTE2: {NOTE 2}
    ]
]

do-trace 53 [
    ?? transactions
] %trading-journal.red

transactions: Update-Readable transactions 'T-2017.12.08-0001/.NOTES/NOTE2 {NOTE 2 CHANGED}  

do-trace 59 [
    ?? transactions
] %trading-journal.red





