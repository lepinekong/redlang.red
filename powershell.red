Red [
    Title: "powershell.red"
]

powershell: function [/startup-dir >startup-directory /startup-command >startup-command][

	unless startup-dir [
		>startup-directory: to-local-file what-dir
	]


	command: rejoin [{start powershell -NoExit -Command "Set-Location '} replace/all >startup-directory "\" "\\"]
	either startup-command [
		startup-command: form >startup-command
		replace/all startup-command "\" "\\" 
		command: rejoin [command ";" >startup-command {'}]
	][
		command: rejoin [command {'}]
	]
	print command
	call command	
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



