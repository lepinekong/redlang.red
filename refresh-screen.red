Red [
    Title: "refresh-screen.red"
]

.refresh-screen: does [

    if not value? '.do-events [
        do https://redlang.red/do-events
    ]
    .do-events/no-wait
]
