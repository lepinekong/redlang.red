Red [
    Title: "to-json.red"
    Based-on: [
        Library: "Altjson"
        Author: "Christopher Ross-Gill"
    ]

]

do https://redlang.red/altjson.red

.to-json: :to-json
to-json: function[block [block!] /compact][

    unless compact [
        return .to-json/pretty block
    ]
    return .to-json block
    
]
