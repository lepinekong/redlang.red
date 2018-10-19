Red [
	Authors: [
		"Toomas Vooglaid" {original code: https://gist.github.com/toomasv/ed9e15d0173f9f80b8bc50c734727b11}
		"Lépine Kong" {evolutions:
			- optional directory
			- filter by extension (/extension)
			- optionally return a block (/return-block)
			- >default-extension: %.txt
		}
	]
	Date: "2018-09-04"
	Changed: ["2018-09-04" "2018-09-05"] 
	Purpose: "Print a directory tree or current directory with filter"
	File: "%treeview.red"
]
if not value? '>default-extension [
	>default-extension: %.txt
]
lib: https://redlang.red/toomasv/dir-tree6.red ; in 0.0.0.2.13
do lib

unless value? '.redlang [
	do https://redlang.red
]
.redlang [do-events alias]
.treeview: function [
	{Examples:
		.treeview
		.treeview %./
		.treeview %/c/projects/test
		.treeview c:\projects\test
		.treeview/extension %/c/projects/test %.html
		>default-extension: %.html
	}
	'>folder [any-type! unset!] {optional directory}
	/help {print help}
	/extension '>extension [any-type!]  {filter by extension}
	/ext '>ext [any-type!]  {same as /extension} ; 0.0.0.2.12
	/dir {directories only}
	/empty-dir {don't exclude empty dir} ; 0.0.0.2.9	
	/return-block {return a block instead of string}
	/out-block {same as /return-block} ; 0.0.0.2.12	
	/silent {silent mode}
	/_build {return the build number for developer}
	/_debug {show debug messages for developer}
	][
	if not value? 'tempSysRead [
		;tempSysRead: :Read
		tempSysRead: get in system/words 'read ; 0.0.0.3.4

		system/words/read: function [
			"Reads from a file, URL, or other port" 
			source [file! url!] 
		][
			block: reverse (tempSysRead source)
		] 	
		
	]    
	>build: [0.0.0.3.4 {
		- Override read for sortinv
		}]

	if _build [
		unless silent [
			print >build
		]
		return >build
	]
	if help [
		print {Examples:
			.treeview
			.treeview %./
			.treeview %/c/projects/test
			.treeview c:\projects\test
			.treeview/extension %/c/projects/test %.html
			>default-extension: %.html
		}
		exit		
	]
    	; start requirements alias 0.0.0.2.12
	if out-block [
		return-block: true
	]

	if ext [
		extension: true
		>extension: >ext
	]
	; finish requirements alias
        >default-folder: %./

	switch type?/word get/any '>folder [
		unset! [
			>folder: >default-folder
		]
	]		
	if suffix: suffix? to-red-file rejoin ["%" form :>folder]  [
		extension: true
		>extension: suffix
		>folder: >default-folder
	]

	;if not extension [
	if (not extension) and (not ext) [	
		>extension: >default-extension
	]
    	>extension: form :>extension
    	filter_rule: compose/only/deep [thru [(>extension) end]] 	.folder: to-red-file form :>folder ; 0.0.0.1
	; start 0.0.0.2.1
	command: copy []

	main-command: copy rejoin ["dir-tree"] ; 0.0.0.2.9
	unless empty-dir [ ; 0.0.0.2.9
		main-command: rejoin [main-command "/non-empty"] ; 0.0.0.2.10 fix 0.0.0.2.9 bug 
	]
	main-command: rejoin [main-command "/expand"] ; 0.0.0.2.9

	if dir [
		main-command: rejoin [main-command "/dir"]
	]
	if extension [
		main-command: rejoin [main-command "/filter"]
	]

	command: to block! main-command

	append command (.folder)

	append command to-lit-word 'all

	if extension [
		append/only command filter_rule ; 0.0.0.2.7
	]
	; finish 0.0.0.2.1
	if _debug [
		?? command
	]
	the-tree>: do command
	either return-block [
		lines: split the-tree> newline ; fix bug 0.0.0.2.10 bad variable name in 0.0.0.2.11
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
    
	system/words/read: :tempSysRead
]
.alias .treeview [treeview tree .tree tree-view .tree-view .dir-tree]
