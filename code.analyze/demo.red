Red [
    Title: "demo.red"
]

do read %../do-trace.red
do read %../code.analyze.red

;list-funcs: function[red-file][
    src: read http://codeops.space/bootstrap/lib.red
    src-block: load src

    list: .func.name.list src-block 
    do-trace 12 [
        ?? list
    ] %demo.red
;]

.func-name: 'emit-nav
src: read http://codeops.space/bootstrap/lib.red
src-block: load src
Ctx: Context src-block

if ((body-of Ctx) = []) [
    new-code: .code.analyze code
    Ctx: Context new-code
]

func-src: get in Ctx .func-name 

do-trace 30 [
    ?? func-src
] %demo.red