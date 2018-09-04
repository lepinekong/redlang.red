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
.redlang [alias]

unless value? '.do-events [
	do https://redlang.red/do-events
]

unless value? 'dir-tree [
	do https://redlang.red/toomasv/dir-tree2.red
]

.treeview: function [
	'>folder [any-type! unset!]
	/extension >extension
	/silent
	][

	switch type?/word get/any '>folder [
		unset! [
			>folder: %./
		]
	]	
	.folder: :>folder
	unless silent [
		print tree: dir-tree (.folder)
	]
	
	return tree

]

