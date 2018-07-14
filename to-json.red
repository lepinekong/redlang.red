Red [
    Title: "to-json.red"
]

do https://redlang.red/altjson.red
.to-json: :to-json
to-json: function[block [block!] /compact][

    unless compact [
        return .to-json/pretty block
    ]
    return .to-json block
    
]
