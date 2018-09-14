Red [
    Title: ""
]

check-red-binary: does [

    reference: #{72FCAC481770B93A9B96232BF503D519317DF63E79D636AB28A06BCC06E9B87A}

    do https://redlang.red/sha256
    exe: system/options/boot
    res: sha256 exe

    either find exe "console-2017-8-3-49893.exe" [
        either res = reference [
            print "red binary is ok"
        ][
            print "red binary is suspicious"
        ]
    ][
        ;TBD
    ]

    print exe
    print res
    return res ; todo: return both exe and res
]





