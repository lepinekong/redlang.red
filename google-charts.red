Red [
	Title: "Google Charts API"
    Reference: http://ross-gill.com/page/Google_Charts_and_REBOL
]

#macro ['use set locals block!] func [s e][
	reduce [
		make function! [
			[locals [object!] body [block!]]
			[do bind body locals]
		]
		make object! collect [
			forall locals [keep to set-word! locals/1]
			keep none
		]
	]
]

if not value? 'use [
	do read http://redlang.red/lib.red
]


Rebol [
	Title: "Google Chart API"
	Version: 0.1.3
	Author: "Christopher Ross-Gill"
	Home: http://ross-gill.com/page/Google_Charts_and_REBOL
	Date: 9-Aug-2008
	Exports: [chart]
	File: %google-charts.r
	Purpose: {Generates a URL to access the Google Charts API}
]


.google-chart: use [
	root types ; settings
	map uses envelop ; core functions
	form-simple form-color form-list form-lists form-data ; type helpers
][

	Comment: {
	; example:

	do read http://redlang.red/google-charts.red

	clip-data: {Adsense Revenue^-300
	Sponsors^-500
	Gifts^-50
	Others^-58}

	view reduce [
		'image google-chart [
			title: "Revenue"
			size: 650x300
			type: 'pie

			; extract raw data
			delimiters: charset "^/^-"
			data: split clip-data delimiters
			labels: extract data 2
			data: extract/index data 2 2

			; format data and labels
			sum: 0
			forall data [sum: sum + data/1: to-integer data/1]
			forall data [change data round 100 * data/1 / sum]
			forall labels [
				labels/1: rejoin [labels/1 " " data/(index? labels) "%"]
			]
		]
	]

	}	

	root: http://chart.apis.google.com/chart?

	types: [
		line "lc" line/xy "lxy" sparkline "ls"
		bar "bvs" bar/horizontal "bhs"
		pie "p3" pie/flat "p"
		map "t" venn "v"
	]

	uses: func [proto [block!] spec [block!]][
		proto: context proto
		func [args [block! object!]] compose/only [
			args: make (proto) args
			do bind (spec) args
		]
	]

	map: func [series [any-block!] action [any-function!] /deep][
		also series: copy/deep series
		while [not tail? series][
			series: either all [deep block? series/1][
				change/only series map/deep series/1 :action
			][
				change/part series action series/1 1
			]
		]
	]

	envelop: func [val [any-type!]][either any-block? val [val][reduce [val]]]

	form-simple: use [to-61 codes][
		codes: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"

		to-61: func [val [number! none!]][
			if none? val [return "_"]
			val: max min 1 val 0
			pick codes 1 + round 61 * val
		]

		func [[catch] data [block!] separator [any-type!]][
			rejoin map data :to-61
		]
	]

	form-color: func [color [tuple!] /local out][
		out: copy ""
		repeat val length? color [
			append out rejoin [back back tail form to-hex color/:val]
		]
		lowercase out
	]

	form-list: func [block [block!] separator [char! string!]][
		remove rejoin map block func [val][
			rejoin [
				separator
				switch/default type?/word val [
					decimal! [round/to val 0.1]
					tuple! [form-color val]
					none! [-1]
				][
					switch/default val [
						color ["bg"] chart ["c"] all ["a"]
						solid ["s"] gradient ["lg"] stripes ["ls"]
					][val]
				]
			]
		]
	]

	form-lists: func [
		block [block!] separator [char! string!] encode [function!]
		/with subseparator [char! string!]
	][
		remove rejoin map block func [block][
			rejoin [separator encode block subseparator]
		]
	]

	form-data: func [data [block!] /local out val /text /flat /simple /label][
		unless parse data: copy/deep data [some block!][
			data: reduce [data]
		]

		case [
			simple [rejoin ["s:" form-lists data "," :form-simple]]
			flat [form-lists/with data "," :form-list ""]
			label [form-list data/1 "|"]
			text [rejoin ["t:" form-lists/with data "|" :form-list ","]]
			true [form-lists/with data "|" :form-list ","]
		]
	]

	uses [
		verbose: false debug: func [val][either verbose [probe val][val]]
		out*: ""
		emit: func ['arg val][repend out* ["&" arg "=" form val]]
		title: none
		size: 320x240
		type: 'line
		simple: no
		data: []
		color: colors: labels: area: bars: scale: none
	][
		clear out*
		if scale [
			if zero? scale [scale: 1]
			data: map/deep data func [value] compose [
				value * (round/to divide pick [100.0 1.0] not simple scale 0.001)
			]
		]
		emit cht any [select types type form type]
		emit chs size
		emit chd either simple [form-data/simple data][form-data/text data]
		case/all [
			title [emit chtt title]
			any [color color: colors][emit chco form-data reduce envelop color]
			labels [emit chl form-data/label envelop labels]
			area [emit chf form-data area]
			bars [emit chbh form-data bars]
		]
		rejoin [root debug next out*]
	]
]

google-chart: :.google-chart
chart: :.google-chart

.google-pie-chart: function[.data][

	; https://developers.google.com/chart/image/docs/gallery/pie_charts

	comment: {
		;usage example:
		pie-chart [
			"Adsense Revenue" 300
			"Sponsors" 500
			"Gifts" 50
			"Others" 58
		]	
	}

	image: chart [
		title: "Revenue"
		size: 650x300
		type: 'pie

		labels: extract .data 2
		data: extract/index .data 2 2

		sum: 0
		forall data [sum: sum + data/1: to-integer data/1]
		forall data [change data round 100 * data/1 / sum]
		
		forall labels [
			labels/1: rejoin [labels/1 " " data/(index? labels) "%"]
		]
	]

	view reduce [
		'image image
	]
]

google-pie-chart: :.google-pie-chart
.pie-chart: :.google-pie-chart
pie-chart: :.google-pie-chart



