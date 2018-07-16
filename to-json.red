Red [
    Title: "to-json.red"
    Based-on: [
        Library: "Altjson"
        Author: "Christopher Ross-Gill"
    ]

]

do https://redlang.red/altjson.red
do https://redlang.red/do-trace

.to-json: :to-json ; for overriding to-json

to-json: function[>block [block!] /compact][   

    unless compact [
        return .to-json/pretty .block
    ]
    return .to-json .block
    
]
