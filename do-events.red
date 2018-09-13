Red [
    Title: "do-events.red"
]

.do-events: function [
    
	{Launch the event loop, blocks until all windows are closed} 
	/no-wait "Process an event in the queue and returns at once" 
	return: [logic! word!]
	/local result 
	win
    /_build
    /silent
][
    >builds: [0.0.0.1.5 {fix september compatibility}]
    if _build [
        unless silent [
            ?? _builds
        ]
        return >builds
    ]
    try [
        either no-wait [
            do-events/no-wait
        ][
            do-events
        ]
    ]
]