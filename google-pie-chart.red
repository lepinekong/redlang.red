Red [
    Title: "google-pie-chart.red"
]

do read http://redlang.red/google-charts.red

.google-pie-chart:  function['.data [word! block! unset!] /title .title /local ][
	switch/default type?/word get/any '.data [
		unset! [
			.data: [
				"Adsense Revenue" 300
				"Sponsors" 500
				"Gifts" 50
				"Others" 58
			]
			.google-pie-chart .data
		]
		word! block! [
			either title [
				..google-pie-chart/title .data .title
			][
				..google-pie-chart .data
			]
			
		]
	] [
		throw error 'script 'expect-arg .data
	]
]

..google-pie-chart: function[.data /title .title][

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

	if not title [
		.title: "pie chart"
	]

	view reduce [
		'title .title
		'image image
	]
]

.pie-chart: :.google-pie-chart
google-pie-chart: :.google-pie-chart
pie-chart: :.pie-chart




