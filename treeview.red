
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
lib: https://redlang.red/toomasv/dir-tree3.red
do lib

unless value? '.redlang [
	do https://redlang.red
]
.redlang [do-events alias]

.treeview: function 
[
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
	/dir {directories only}
	/return-block {return a block instead of string}
	/silent {silent mode}
	/_build {return the build number for developer}
	/_debug {show debug messages for developer}
	]
[

	>build: [0.0.0.2.4 {- refactoring}]

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

	switch type?/word get/any '>folder [
		unset! [
			>folder: %./
		]
	]		

	if suffix: suffix? to-red-file rejoin ["%" form :>folder]  [
		extension: true
		>extension: suffix
		>folder: %./

	]		

	if not extension [
		>extension: >default-extension
	]
	>extension: form :>extension


	filter_rule: compose/only/deep [thru [(>extension) end]] 

	.folder: to-red-file form :>folder ; 0.0.0.1.

	; start 0.0.0.2.1
	command: copy []
	main-command: copy rejoin ["dir-tree/expand"]

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
		append command filter_rule
	]
	; finish 0.0.0.2.1	
	

	if _debug [
		;command: compose/only/deep [dir-tree/filter/expand (.folder) (filter_rule) 'all]
		?? command
	]
	the-tree>: do command

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