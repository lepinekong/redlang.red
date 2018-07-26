Red [
	Author: "Toomas Vooglaid"
	Date: "2017-05-07"
	Changed: "2018-07-09"
	Purpose: "Print a directory tree"
	File: "%dir-tree.red"
]

unless value? '.do-events [
	do https://redlang.red/do-events
]


context [
	; Some helpers
	get-char: func [hex][to-char to-integer hex]
	map: func [series [series!] fn [any-function!]][
		out: make type? series []
		foreach i series [append out fn i]
	]
	filter: func [series [series!] fn [any-function!]][
		out: make type? series []
		foreach i series [if fn i [append out i]]
		out
	]
	set 'dir-tree func [
		{Prints a directory tree}
		value 							"Initial directory"
		; Public refinements
		/expand 	levels				"How many levels to print? ('all, 0, 1, 2,... Default: 2)"
		/only							"Are we considering directories only?"
		/redish							"Use Red format"
		/lines							"Show number of lines in file"
		; Refinements for internal use (FIU)
		/dep		depth				"FIU, to keep track of depth"
		/only-dirs	dirs				"FIU, to carry the previous decision value around between calls"
		/pref 		prefix 				"FIU, to carry on the current prefix"
		/chpref 	changeprefix 		"FIU, to carry on the next item's prefix"
		/dir 		directory			"FIU, to keep track of directories"
		/red		frm					"FIU, to carry on format"
		/lin 		lins
		/local index length str	file f
	][
		; Tree-building material
		;"├─" ; to-string map [#{251C} #{2500}] :get-char 
		;"└─" ; to-string map [#{2514} #{2500}] :get-char
		;"│ " ; to-string map [#{2502} #" "] :get-char
		str: 			["├─" "└─" "│ " "  "]
		prefix: 		any [prefix ""]
		changeprefix: 	any [changeprefix ""]
		directory: 		any [directory none]									
		levels: 		any [levels 2]
		depth: 			any [depth 0]
		dirs: 			any [dirs only]
		frm: 			any [frm redish]
		lins:			any [lines lins]
		
		switch type?/word value [
			file! [
				; if directory is not set, set it to absolute path - 1 and value to the last element of this path
				unless directory [set [directory value] split-path normalize-dir value]	
				all [
					any [not dirs dir? value] 							; whether only directories are printed
					any [levels = 'all levels >= depth]					; is depth limited?
					.do-events/no-wait
					print either dir? value [							; print current line of tree
						append copy prefix either frm [mold value][value] 
					][
						either f: attempt [read rejoin [directory value]] [
							n: 0 parse f [some [thru #"^/" (n: n + 1)]] n: n + 1
						][n: "?"]
						file: append copy prefix either frm [mold value][value]
						;reduce [lines n]
						either lins [append file rejoin [" (" n #")"]][file]
					]
					.do-events/no-wait
				]
				all [
					dir? value											; if this is directory
					any [levels = 'all levels > depth]					; and and we have to dig deeper
					if contents: attempt [read directory/:value][		; and it is not a fake directory
						; recursive call to myself with directory contents - send items to preprinting preparation
						dir-tree/pref/dir/only-dirs/expand/dep/red/lin contents copy changeprefix directory/:value dirs levels depth + 1 frm lins
					]
				]
			]
			block! [
				index: 1												; initial position
				if dirs [value: filter value :dir?]						; are we considering directories only?
				length: length? value									; how many elements?
				foreach item value [
					either index = length [								; if this is last element
						newprefix: copy str/2							; set new prefix to 'corner'
						if dir? item [									; and if this is a directory
							changeprefix: append copy prefix copy str/4	; append some empty space to previous prefix for next items
						]
					][													; if this is not last piece
						newprefix: copy str/1							; set new prefix to '|-'
						if dir? item [									; and if this is a directory
							changeprefix: append copy prefix copy str/3	; append '| ' to previous prefix for next items
						]
					]
					addprefix: append copy prefix copy newprefix		; this is printed before the current item
					index: index + 1									; keep counting
					; send current item to the printing house
					dir-tree/pref/chpref/dir/only-dirs/expand/dep/red/lin item copy addprefix copy changeprefix directory dirs levels depth frm lins
				]
			]
		]
	]
]