Red [
    Title: "trading-journal.red"
]

do read http://redlang.red/crud-readable.red
transactions: read-readable %db/trading-journal.read
?? transactions

transactions: Add-Readable transactions 'T-2017.12.08-0001 [

    .SYMBOL: AAPL
    .CURRENCY: DOLLAR
    .BROKER: GOLDMAN-SACHS         

    .ACTION-ENTRY: BOUGHT
    .QTY-ENTRY: 100
    .PRICE-ENTRY: 175.95
    .DATETIME-ENTRY: 18/12/2017

]




