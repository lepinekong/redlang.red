Red [
    Title: ""
]

check-red-binary: function[
    /silent
][

    reference: #{72FCAC481770B93A9B96232BF503D519317DF63E79D636AB28A06BCC06E9B87A}

    if error? try [
        do https://redlang.red/sha256
    ][
        do https://raw.githubusercontent.com/lepinekong/redlang.red/master/sha256.red
    ]

    exe: system/options/boot
    sha: sha256 exe

    either find exe "console-2017-8-3-49893.exe" [
        either sha = reference [
            print "red binary is ok"
        ][
            print "red binary is suspicious"
            ?? reference
        ]
    ][
        ;
    ]

    unless silent [
        print exe
        print sha
    ]

    return sha ; todo: return both exe and res
]

check-red-binary





