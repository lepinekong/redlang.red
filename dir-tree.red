Red [
	Author: "Toomas Vooglaid"
	Date: "2017-05-07"
	Changed: "2018-07-09"
	Purpose: "Print a directory tree"
	File: "%dir-tree.red"
]

unless value? '.redlang [
	do https://redlang.red
]
.redlang [do-events alias]

do https://redlang.red/toomasv/dir-tree2.red

.treeview: function [
	'>folder [any-type! unset!]
	/extension >extension
	/silent
	/build
	][

        >build: 0.0.0.1.18.1

        if build [
            unless silent [
                print >build
            ]
            return >build
        ]		

	switch type?/word get/any '>folder [
		unset! [
			>folder: %./
		]
	]	
	.folder: :>folder
	the-tree: dir-tree (.folder)

	if extension [
		>extension: form >extension
		lines: split the-tree newline	
		remove lines ; remove first line
		filtered-tree: copy ""
		forall lines [
			line: lines/1
			index: index? lines
			if ((index? lines) > 1) [ ; super bug because forgot () around index? lines
				append filtered-tree newline
			]
			append filtered-tree line
		]
		the-tree: copy filtered-tree

		; the-tree: copy ""
		; forall lines [
		; 	line: lines/1
		; 	index: index? lines
		; 	print index
		; 	print line
		; 	; if line <> "" [
		; 	; 	if (index? lines > 2) [
		; 	; 		append the-tree newline
		; 	; 	]
		; 	; 	append the-tree line
		; 	; ]

		; ]		
	]

	; unless silent [
	; 	print the-tree
	; ]
	
	return the-tree

]

.alias .treeview [tree .tree treeview tree-view .tree-view .dir-tree]

