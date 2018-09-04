Red [
	Authors: [
		"Toomas Vooglaid" {original code}
		"Lépine Kong" {evolutions:
			- optional directory
			- filter by extension (/extension)
			- optionally return a block (/return-block)
		}
	]
	Date: "2017-05-07"
	Changed: "2018-07-09"
	Purpose: "Print a directory tree"
	File: "%dir-tree2.red"
]

unless value? '.redlang [
	do https://redlang.red
]
.redlang [do-events alias]

do https://redlang.red/toomasv/dir-tree2.red

.treeview: function [
	'>folder [any-type! unset!] {optional directory}
	/extension >extension {filter by extension}
	/return-block {return a block instead of string}
	/silent {silent mode}
	/build {return the build number for developer}
	][

        >build: 0.0.0.1.21

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

	lines: split the-tree newline	
	remove lines ; remove first line	

	either extension [

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
	
	either return-block [
		return lines
	][
		return the-tree
	]
	

]

.alias .treeview [tree .tree treeview tree-view .tree-view .dir-tree]

