Red [
    Title: "to-json.red"
]

do https://redlang.red/altjson.red
.to-json: :to-json
to-json: function[block [block!]][
    .to-json/pretty block
]
