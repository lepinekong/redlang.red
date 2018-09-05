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

	>build: 0.0.0.1.6

	if build [
		unless silent [
			print >build
		]
		return >build
	]	

	if suffix: suffix? to-red-file rejoin ["%" form :>folder]  [
		extension: true
		>extension: suffix
		>folder: %./

	]		

	if not extension [
		>extension: %.txt
	]
	>extension: form :>extension

	filter_rule: compose [thru (>extension)]

	switch type?/word get/any '>folder [
		unset! [
			>folder: %./
		]
	]	
	.folder: :>folder


	
	the-tree>: dir-tree/expand/filter (.folder) 'all filter_rule

	either return-block [
		lines: split the-tree newline	
		remove lines ; remove first line	
		unless silent [
			print the-tree>
		]			
		return lines
	][
		either not silent [
			print the-tree>
		][
			return the-tree>
		]
	]
]

.alias .treeview [treeview tree .tree tree-view .tree-view .dir-tree]
