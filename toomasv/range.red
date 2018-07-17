Red [
	Author: "Toomas Vooglaid"
	Date: 26-11-2017
]
range: function [val1 val2 /step stp /limit /enbase ebase /debase dbase /unicode][
	stp+?: none
	stp: any [stp either any [percent? val1 percent? val2] [1%][1]]
	if any [all [block? stp zero? stp/3] zero? stp] [return none]
	case [
		debase [
			unless binary? val1 [
				either any-string? val1 [
					val1: debase/base form val1 dbase
				][
					cause-error ['user 'message ["Only `any-string!` will be debased!"]]
				]
			]
			unless limit or binary? val2 [val2: debase/base val2 dbase]
		]
		enbase [
			unless binary? val1 [val1: debase/base val1 ebase]
			unless limit or binary? val2 [val2: debase/base val2 ebase]
		]
	]
	if binary? val1 [
		val1: to-integer val1 val2: to-integer val2
		binary: true 
		ebase: any [ebase 16]
	]
	if all [
		block? stp 
		any [date? val1 time? val1]
	][
		if negative? stp/3 [
			cause-error 'user 'message ["Negative values not allowed in block step!"]
		]
		stp+?: either find stp '- [false][true]
	]
	if limit [
		val2: either block? stp [
			val: val1 
			val/(stp/1): val/(stp/1) + (val2 - 1 * pick reduce [stp/3 0 - stp/3] stp+?)
			val
		][
			val1 + (val2 - 1 * stp)
		]
	]
	rng: to-block case [
		stp+? [pick reduce [val1 val2] stp+?]
		(number? stp) or (time? stp) [pick reduce [val1 val2] stp+?: stp > 0]
		true [stp+?: true val1]
	]
	comp: 		pick reduce [:<= :>=] 			(growing?: val1 < val2) xor stp+?
	inc: 		pick reduce [:+ :-] 			either block? stp [growing? = stp+?][growing?]
	addnext: 	pick reduce [:append :insert] 	stp+?
	changing: 	pick reduce [val1 val2] 		stp+?
	limit: 		pick reduce [val2 val1] 		stp+?
	either block? stp [
		while [
			changing/(stp/1): changing/(stp/1) inc stp/3
			limit comp changing
		][
			head addnext rng changing
		]
	][
		while [limit comp changing: changing inc stp] [
			head addnext rng changing
		]
	]
	case [
		binary [forall rng [
			rng/1: either enbase [
				system/words/enbase/base to-binary rng/1 ebase
			][	to-binary rng/1]
		]]
		unicode [forall rng [to-char rng/1]]
	]
	rng
]