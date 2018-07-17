Red [
	Author: "Toomas Vooglaid"
	Date: 2017-12-16
    Original-Url: https://gist.github.com/toomasv/e819fa2452f38a15cea6e20182ab9309
	Needs: %range.red
	Needs-Gist: https://gist.github.com/toomasv/0e3244375afbedce89b3719c8be7eac0
]

do %range.red

context [
	md: make font! [name: "Consolas" size: 12 color: black]
	ft: make font! [name: "Tahoma"   size: 36 color: black];;Lucida Sans Unicode;Unifont;EversonMono
	dc: make font! [name: "Consolas" size: 8  color: 0.0.150]
	hx: make font! [name: "Consolas" size: 8  color: 0.150.0]
	h: "0123456789ABCDEF"
	dr: copy []
	dx: 60 dy: 65
	chars: copy []
	make-draw: function [chars][
		k: 0
		append clear dr [font hx]
		forall h [
			x: (index? h) - 1 * dx + 61
			append dr compose [
				text (as-pair x 2) (to-string h/1)
			]
		]
		forall chars [
			j: to-integer debase/base append copy "0" last enbase/base to-binary chars/1 16 16
			x: j * dx + 40
			k: either 1 = index? chars [j][k + 1]
			i: k / 16
			either i < 9 [
				y: i * dy + 20
				;probe reduce [x y index? chars j k i]
				if any [1 = index? chars j = 0][
					append dr compose [
						font hx 
						text (as-pair 2 y + 19) (copy/part skip to-string to-hex to-integer chars/1 2 5)
					]
				]
				append dr compose [font ft text (as-pair x y) (to-string chars/1)]
				append dr compose [font dc text (as-pair x y + 57) (
					st: to-string to-integer chars/1 
					pad/left st 8 - (8 - (length? st) / 2)
				)]
			][
				self/lastchar: to-integer first back chars 
				
				break
			]
		]
		dr
	]
	show: function [chars][
		view compose/deep [
			chart: base 1000x610 white
				draw [(make-draw chars)]
			at 995x10  btn-up: button 15x15 "˄" [face/enabled?: not 0 >= chars/1 chart/draw: make-draw unicode/prev 144]
			;at 995x25  scr-bar: button 15x595
			at 995x605 btn-down: button 15x15 "˅" [chart/draw: make-draw unicode/next 144]
			text-list 200x610 font md 
				data [(sym: split form keys-of page #" ")]
				on-change [chart/draw: make-draw unicode to-word pick sym face/selected]
		]
	]

	page: #(
		latin:				[#0000   #007F]
		ascii: 				[#0020   #007E]
		latin-1_supplement: [#0080   #00FF]
		latin-extA:			[#0100   #017F]
		latin-extB:			[#0180   #024F]
		greek:				[#0370   #03FF]
		cyrillic: 			[#0400   #04FF]
		hebrew:				[#0590   #05FF]
		arabic:				[#0600   #06FF]
		devenagari:			[#0900   #097F]
		georgian:			[#10A0   #10FF]
		hangul-jamo:		[#1100   #11FF]
		latin-additional:	[#1E00   #1EFF]
		hiragana:			[#3040   #309F]
		katakana:			[#30A0   #30FF]
		cjk:				[#4E00   #9FFF]
		
		punctuation:		[#2000   #206F]
		currency:			[#20A0   #20CF]
		letterlike: 		[#2100   #214F]
		arrows: 			[#2190   #21FF]
		math-ops:			[#2200   #22FF]
		technical:			[#2300   #23FF]
		box-drawing:		[#2500   #257F]
		block-elements:		[#2580   #259F]
		geometric: 			[#25A0   #25FF]
		symbols:			[#2600   #26FF]
		dingbats:			[#2700   #27BF]
		arrows-symbols:		[#2B00   #2BFF]
		hexagrams:			[#4DC0   #4DFF]
		weather:			[#2600   #2609]
		pointing:			[#261A   #261F]
		religion:			[#2626   #262F]
		trigrams:			[#2630   #2637]
		astrology:			[#263D   #2647]
		zodiac:				[#2648   #2653]
		chess: 				[#2654   #265F]
		card-suite:			[#2660   #2667]
		musical:			[#2669   #266F]
		dice:				[#2680   #2685]
		mono-digrams:		[#268A   #268F]
		checkers:			[#26C0   #26C3]
		map:				[#26E8   #26FF]
		math-A:				[#27C0   #27EF]
		math-B:				[#2980   #29FF]
		math-ops-suppl:		[#2A00   #2AFF]
		domino:				[#01F030 #01F09F]
		cards:				[#01F0A0 #01F0FF]
		picts:				[#01F300 #01F5FF]
		emoticons:			[#01F600 #01F64F]
		traffic:			[#01F680 #01F6FF]
		alchemy:			[#01F700 #01F77F]
		geometric-ext:		[#01F780 #01F7FF]
		picts2:				[#01F900 #01F9FF]
	)
	lastchar: firstchar: none
	type: function [val][
		switch type?/word val [
			char!		[to-integer val]
			word! 		[to-integer debase/base skip to-string val 2 16]
			integer! 	[val]
			binary! 	[to-integer val]
			issue!		[to-integer debase/base to-string val 16]
		]
	]
	set 'unicode function [val /from lower /to upper /limit lim /next /prev /chart][
		if val = 'help [print "List of symbols:" probe keys-of page return none]
		if val = 'charts [chart: true val: 'latin]
		all [vals: page/:val set [val upper] vals]
		all [next upper: either integer? val [lastchar + val][val] val: lastchar + 1]
		all [prev val: either integer? val [firstchar - val][firstchar - 1] upper: firstchar - 1]
		val: type val
		all [from val: val + type lower]
		all [limit upper: val + lim - 1]
		upper: type any [upper val]
		set [firstchar lastchar] reduce [val upper]
		collect/into [foreach i range val upper [keep to-char i]] clear chars 
		either chart [show chars][chars]
	]
]
