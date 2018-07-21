Red [
    Title: "powershell.red"
]

lazy-load: function ['>function][

	.function: form >function

	switch .function [		
		"powershell-profile" [
			load-powershell-profile ; will load powershell-profile function if not already loaded
			powershell-profile ; will call powershell function
		]	
	]
]

load-powershell-profile: function [][
	unless value? 'powershell-profile [
		do https://redlang.red/powershell/powershell-profile.red
		return true
	]
	return false
]

system/lexer/pre-load: func [src part][
    parse src [
        any [
            s: [
                ["powershell-profile^/" | "powershell-profile" end] (new: "lazy-load powershell-profile")
				| ["powershell profile^/" | "powershell profile" end] (new: "lazy-load powershell-profile")
            ] e: (s: change/part s new e) :s
            | skip
        ]
    ]
]



