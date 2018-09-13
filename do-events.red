Red [
    Title: "do-events.red"
]

.do-events: function [
    
	{Launch the event loop, blocks until all windows are closed} 
	/no-wait "Process an event in the queue and returns at once" 
	return: [logic! word!] "Returned value from last event" 
	/local result 
	win
][
    either error? try [
        either no-wait [
            do-events/no-wait
        ][
            do-events
        ]
    ][
        return false
    ][
        return true
    ]
]