Red [
    Title: "Redlang general lib"
    File: %lib.red
    Published-Url: http://redlang.red/lib.red
]

.doc: func [doc][] ; dumb function which does nothing : it just acts as marker for documentation

.use: func [locals [block!] body [block!]][

    .doc [
        .title: {.use function}
        .snippet-url: 

        .description: {.use allows to create light section for structuring your code
            with local variables without creating a more heavier function, object or file which breaks linearity and makes harder to read and understand your code.
        }

        .alias: [use]

        .example: [
            ; paste .doc and .use functions in red console before pasting the example below
            count: 10
            .use [count][
                count: 0
                count: count + 1
                print count ; 1
            ]
            print count ; 10
        ]
    ]

	do bind body make object! collect [
		forall locals [keep to set-word! locals/1]
		keep none
	]
]

use: :.use


