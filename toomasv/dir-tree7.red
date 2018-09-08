Red [
	Author: "Toomas Vooglaid"
	Date: "2017-05-07"
	Changed: "2018-09-08"
	Purpose: "Print a directory tree"
	File: "%dir-tree.red"
]
context [
	; Some helpers
	get-char: func [hex][to-char to-integer hex]
	_map: function [series [series!] fn [any-function!]][
		out: make type? series []
		foreach i series [append out fn i]
	]
	_filter: function [series [series!] fn [any-function!]][
		out: make type? series []
		foreach i series [if fn i [append out i]]
		out
	]
	out: copy {}
	; See @rebolek 2018-09-05 https://gitter.im/red/help?at=5b8fe0b411227d711d1ca039
	wildcard: func [
		pattern /local rule char rule2
	][
		rule: copy [] 
		parse pattern [
			some [#"*" (append rule 'thru) | #"?" (append rule 'skip) | set char skip (append rule char)]
		] 
		append rule 'end
		parse rule rule2: [some ['thru s: (insert/only s append copy [] take/part s tail s parse s/1 rule2) | skip]] ; My addition
		rule
	]
	empty-tree?: func [dir val /filter rule /local block item][
		block: read dir/:val
		if filter [block: _filter block func [i][any [dir? i parse i rule]]]
		;probe block
		either empty? block [return true][
			foreach item block [
				either dir? item [
					unless either filter [
						empty-tree?/filter dir/:val item rule
					][
						empty-tree? dir/:val item
					] [return false]
				][
					return false
				]
			]
		]
		true
	]
	sort-dir: func [dir ord /local date blk blk1 cmd found item][
		date: none
		switch type?/word ord [word! [ord: to-block ord] string! [ord: load/all ord]]
		if 1 < length? multi: intersect ord [created modified accessed] [
			foreach word next reverse multi [
				remove ord: find head ord word 
				if ord/1 = 'desc [remove ord]
			]
		]
		ord: parse head ord [collect some [
			'size opt ['desc keep (#"-")] keep (#"S")
		|	'name opt ['desc keep (#"-")] keep (#"N")
		|	'ext opt ['desc keep (#"-")] keep (#"E")
		|	(date: none) set date ['created | 'modified | 'accessed] opt ['desc keep (#"-")] keep (#"D")
		]]
		ord: rejoin ord
		append cmd: copy "dir /B /O:" ord
		if date [append append cmd copy " /T:" select [created "C" modified "W" accessed "A"] date]
		append append cmd space append/only clear {} to-local-file normalize-dir dir
		call/output cmd blk: clear {}
		blk: split blk #"^/"
		remove-each item blk [item = ""]
		call/output append copy cmd " /A:D" blk1: clear {}
		blk1: split blk1 #"^/"
		remove-each item blk1 [item = ""]
		forall blk1 [if found: find head blk blk1/1 [found/1: append found/1 #"/"]]
		blk: head blk
		forall blk [blk/1: to-file blk/1]
		head blk
	]
	make-dir-tree: func [
		value 							"Initial directory"
		; Public refinements
		/expand 	levels				"How many levels to print? ('all, 0, 1, 2,... Default: 2)"
		/only							"Are we considering directories only?"
		/redish							"Use Red format"
		/lines							"Show number of lines in file"
		/filter 	rule				"Filter file names"
		/non-empty						"Non-empty directories only"
		/sort		ord 				"Sorted output"
		; Refinements for internal use (FIU)
		/dep		depth				"FIU, to keep track of depth"
		/only-dirs	dirs				"FIU, to carry the previous decision value around between calls"
		/pref 		prefix 				"FIU, to carry on the current prefix"
		/chpref 	changeprefix 		"FIU, to carry on the next item's prefix"
		/dir 		directory			"FIU, to keep track of directories"
		/red		frm					"FIU, to carry on format"
		/lin 		lins
		/ne			nempty
		/order		ordr
		/local index length str	file f
	][
		; Tree-building material
		;"├─" ; to-string _map [#{251C} #{2500}] :get-char 
		;"└─" ; to-string _map [#{2514} #{2500}] :get-char
		;"│ " ; to-string _map [#{2502} #" "] :get-char
		str: 			["├─" "└─" "│ " "  "]
		prefix: 		any [prefix ""]
		changeprefix: 	any [changeprefix ""]
		directory: 		any [directory none]									
		levels: 		any [levels 2]
		depth: 			any [depth 0]
		dirs: 			any [dirs only]
		frm: 			any [frm redish]
		lins:			any [lines lins]
		nempty:			any [nempty non-empty]
		ordr: 			any [ordr ord]
		
		switch type?/word value [
			file! [
				; if directory is not set, set it to absolute path and set value to the last element of this path
				unless directory [set [directory value] split-path normalize-dir value]	
				all [
					any [not dirs dir? value] 							; whether only directories are printed
					any [levels = 'all levels >= depth]					; is depth limited?
					any [dir? value not rule parse value rule]			; are we filtering filenames?
					any [												; are we excluding empty dirs?
						not dir? value
						not nempty
						either rule [
							not empty-tree?/filter directory value rule
						][
							not empty-tree? directory value
						]
					]
					repend out [either dir? value [				; add this item to output
						append copy prefix either frm [mold value][value] 
					][
						either f: attempt [read rejoin [directory value]] [
							n: 0 parse f [some [thru #"^/" (n: n + 1)]] n: n + 1
						][n: "?"]
						file: append copy prefix either frm [mold value][value]
						;reduce [lines n]
						either lins [append file rejoin [" (" n #")"]][file]
					] newline]
				]
				all [
					dir? value											; if this is directory
					any [levels = 'all levels > depth]					; and and we have to dig deeper
					if contents: either ordr [sort-dir directory/:value ordr][attempt [read directory/:value]][		; and it is not a fake directory
						; recursive call to myself with directory contents - send items to preparation for output
						make-dir-tree/pref/dir/only-dirs/expand/dep/red/lin/filter/ne/order contents copy changeprefix directory/:value dirs levels depth + 1 frm lins rule nempty ordr
					]
				]
			]
			block! [
				index: 1												; initial position
				if dirs [value: _filter value :dir?]					; are we considering directories only?
				if rule [value: _filter value func [i][any [dir? i parse i rule]]] ; are filenames filtered?
				if nempty [
					value: _filter value func [i][
						either dir? i [
							not either rule [
								empty-tree?/filter directory i rule
							][
								empty-tree? directory i
							]
						][true]
					]
				]
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
					make-dir-tree/pref/chpref/dir/only-dirs/expand/dep/red/lin/filter/ne/order item copy addprefix copy changeprefix directory dirs levels depth frm lins rule nempty ordr
				]
			]
		]
	]
	set 'dir-tree func [
		value 									"Initial directory"
		; Public refinements
		/expand 	levels [word! integer!]		"How many levels to print? ('all, 0, 1, 2,... Default: 2)"
		/only									"Are we considering directories only?"
		/redish									"Use Red format"
		/lines									"Show number of lines in file"
		/filter		rule [string! block!] 		"Filter file names"
		/non-empty								"Non-empty directories only"
		/sort		ord [word! string! block!] 	"Sorted output (name, size, ext, (created|modified|accessed) [desc]?) Windows-only"
		/local refs ref args arg cmd
	][
		out: copy {}
		refs: copy reduce ['to-path copy [make-dir-tree] 'value]
		args: copy []
		foreach ref [only redish lines non-empty][if get ref [append refs/2 ref]]
		if expand [append refs/2 'expand append refs either levels = 'all [to-paren [to-lit-word 'all]][levels]]
		if filter [append refs/2 'filter append/only refs either string? rule [wildcard rule][rule]]
		if sort [append refs/2 'sort append/only refs switch type?/word ord [word! [to-block ord] string! [load/all ord] block! [ord]]]
		do reduce refs
		out
	]
]
