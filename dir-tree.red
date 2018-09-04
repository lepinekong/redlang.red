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

        >build: 0.0.0.1.19.1

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

		lines: split the-tree newline	
		remove lines ; remove first line

		>extension: remove form >extension ; 0.0.0.1.20 bug here !!! ".red" instead of "red"
		filtered-tree: copy ""
		forall lines [
			line: lines/1
			index: index? lines

			filename: trim/all line
			ext: last (split filename ".") 
			if (ext = >extension) [
				if (filtered-tree <> "") [ ; super bug because forgot () around index? lines
					append filtered-tree newline
				]
				append filtered-tree line
			]

		]
		the-tree: copy filtered-tree
	
	]

	unless silent [
		print the-tree
	]
	
	return lines

]

.alias .treeview [tree .tree treeview tree-view .tree-view .dir-tree]

