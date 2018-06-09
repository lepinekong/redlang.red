Red [
    Title: "use.red"
    Alias: [
        %use
    ]
    In: [
        %authoring.red
    ]
]

.use: func [locals [block!] body [block!]][
	do bind body make object! collect [
		forall locals [keep to set-word! locals/1]
		keep none
	]
]