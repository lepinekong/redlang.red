Red [
    Title: "powershell.red"
]

; system/lexer/pre-load: func [src part][
;     parse src [
;         any [
;             s: [
;                 ["powershell profile^/" | "powershell profile" end] (new: "lazy-load powershell-profile")
;             ] e: (s: change/part s new e) :s
;             | skip
;         ]
;     ]
; ]

lazy-load: function ['>function][

	switch >function [

	'powershell-profile [
		if not value? 'powershell-profile [
			do https://redlang.red/powershell/powershell-profile.red
		]
		powershell-profile
	]
]




powershell.profile: function [][
	;USERNAME: get-env "username"
	;call/show rejoin [{notepad.exe C:\Users\} USERNAME {\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1}]
    USERPROFILE: get-env "USERPROFILE"
	call/show rejoin [{notepad.exe } {"} USERPROFILE {\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1} {"}]
]
powershell-profile: :powershell.profile


