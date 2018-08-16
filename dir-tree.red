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

do https://redlang.red/toomasv/dir-tree.red

do https://redlang.red/alias
alias dir-tree [treeview tree-view]
