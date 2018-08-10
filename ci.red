Red [
    Title: "ci.red"
]

;--- boot start initialize directory
initial-directory: copy []

if empty? initial-directory [
    if error? try [
        folder: pick split-path system/options/script 1
    ][
        folder: what-dir
    ]

    either not none? folder [
        append initial-directory folder
    ][
        append initial-directory what-dir
    ]
] 
;--- boot end initialize directory

do http://redlang.red/do-trace

;--- start boot to initialize script folder 
if not value? 'get-parent-folder [

    if error? try [
        do https://redlang.red/get-folder
        print [{loaded} https://redlang.red/get-folder]

    ][
        print [{internet connection error}]
        if error? try [
            do %libs/get-folder
        ][
            print [{cannot load} {lib/get-folder}]
        ]
    ]
]
;--- end boot to initialize script folder ---


script: system/options/script

script-folder: get-parent-folder script

local-domain-path: rejoin [{C:\rebol\.system.user\.data\.activities\} local-domain-subfolder]
local-github-path: rejoin [local-domain-path github-subfolder]

splitted-script: split (get-short-filename script) "."

iteration-number: pick splitted-script 2

splitted-filename: split form short-filename "."
filename: (pick splitted-filename 1) 
extension: (pick splitted-filename 2)

updated-file: rejoin [
    filename 
    {.} iteration-number {.} 
    extension
]

.message: rejoin [
    updated-file
    { } {build.iteration: } build-number {.} iteration-number 
]

;--- copy file ---
do https://redlang.red/copy-files
copy-file/force source-file: rejoin [script-folder updated-file]
target-file: to-red-file rejoin [local-github-path short-filename]
;--- commit --- 
do https://quickrun.red/git-commit
do https://redlang.red/cd ; weird cd exists already git-commit but it generates error

cd (local-domain-path)
commit (.message)

cd (local-github-path)
commit (.message)


