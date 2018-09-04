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

do https://redlang.red/toomasv/dir-tree2.red

do https://redlang.red/alias


.treeview: function [
	'>folder [any-type! unset!]
	/extension >extension
	/silent
	/build
	][

        >build: 0.0.0.1.4.2

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
	unless silent [
		print the-tree: dir-tree (.folder)
	]
	
	return the-tree

]

.alias .treeview [tree .tree treeview tree-view .tree-view .dir-tree]

