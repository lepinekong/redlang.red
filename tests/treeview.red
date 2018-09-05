Red [
	Authors: [
		"Toomas Vooglaid" {original code: https://gist.github.com/toomasv/ed9e15d0173f9f80b8bc50c734727b11}
		"Lépine Kong" {evolutions:
			- optional directory
			- filter by extension (/extension)
			- optionally return a block (/return-block)
		}
	]
	Date: "2018-09-04"
	Changed: ["2018-09-04" "2018-09-05"] 
	Purpose: "Print a directory tree or current directory with filter"
	File: "%treeview.red"
]

lib: https://redlang.red/toomasv/dir-tree3.red
do lib

unless value? '.redlang [
	do https://redlang.red
]
.redlang [do-events alias]

.treeview: function [
	'>folder [any-type! unset!] {optional directory}
	/extension '>extension {filter by extension}
	/dir {directories only}
	/return-block {return a block instead of string}
	/silent {silent mode}
	/build {return the build number for developer}
	][

	>build: 0.0.0.1.4

	if build [
		unless silent [
			print >build
		]
		return >build
	]		

	>extension: to-red-file form :>extension

	switch type?/word get/any '>folder [
		unset! [
			>folder: %./
		]
	]	
	.folder: :>folder
	filter_file: function [filename][
		ext: last (split filename ".") 
		if (ext = %.red) [
			return filename
		]	
		return none	
	]

	the-tree>: dir-tree/expand/filter (.folder) 'all filter_file

	; lines: split the-tree newline	
	; remove lines ; remove first line	

	; if extension [

	; 	>extension: remove form >extension ; 0.0.0.1.20 bug here !!! ".red" instead of "red"
	; 	filtered-tree: copy ""
	; 	forall lines [
	; 		line: lines/1
	; 		index: index? lines

	; 		filename: trim/all line
	; 		ext: last (split filename ".") 
	; 		if (ext = >extension) [
	; 			if (filtered-tree <> "") [ ; super bug because forgot () around index? lines
	; 				append filtered-tree newline
	; 			]
	; 			append filtered-tree line
	; 		]

	; 	]
	; 	the-tree: copy filtered-tree
	
	; ]

	unless silent [
		print the-tree>
	]
	
	either return-block [
		lines: split the-tree newline	
		remove lines ; remove first line		
		return lines
	][
		return the-tree>
	]
	

]

.alias .treeview [treeview tree .tree tree-view .tree-view .dir-tree]

