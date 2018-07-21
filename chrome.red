Red [
    Title: "chrome.3.red"
    Iterations: [
        0.0.0.3.6 {added | "take screenshot" copy arg1 to space copy arg2 to space to newline } 
        0.0.0.3.5 {added | "Usage: take-screenshot"}        
        0.0.0.3.4 {fixed}
        0.0.0.3.3 {debugging}
        0.0.0.3.2 {debugging}
        0.0.0.3.1 {*** Syntax Error: {"lazy-load-chrome take-screenshot    ;}}
    ]
]

load-take-screenshot: function [][

    unless value? 'take-screenshot [
        either exists? %chrome/take-screenshot.2.red [
            do %chrome/take-screenshot.2.red
        ][
            do https://redlang.red/chrome/take-screenshot.red
        ]
        
        return true
    ]
    return false
] 

lazy-load-chrome: function ['>function][   

	.function: form >function

	switch .function [		
		"take-screenshot" [
			load-take-screenshot
		]	
	]
]

system/lexer/pre-load: func [src part][
    parse src [
        any [
            s: [
                ["take-screenshot:" | "take-screenshot." | "Usage: take-screenshot"] 
            ] skip
            |            
            s: o: [
                [
                "take-screenshot" copy arg1 to space copy arg2 to space to newline 
                | "take-screenshot" copy arg1 to space copy arg2 to end
                "take screenshot" copy arg1 to space copy arg2 to space to newline 
                | "take screenshot" copy arg1 to space copy arg2 to end                
                ] 
                (new: rejoin ["lazy-load-chrome take-screenshot" newline "take-screenshot" { } arg1 { } arg2] )
            ] e: (s: change/part s new e) :s 
            | skip
        ]
    ]
]

do {take screenshot https://google.com c:\test\chrome.6.png}
;do %chrome/take-screenshot.red

