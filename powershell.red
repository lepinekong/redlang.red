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

lazy-load powershell-profile



