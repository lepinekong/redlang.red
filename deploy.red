Red [
    Title: ""
]

if not value? '.redlang [
    do https://redlang.red
]
.redlang [cd copy-files git-commit]

.deploy: function [
    '>file 
    '>target [any-type! unset!]
    '>commit-script-folder [any-type! unset!]
][
    switch/default type?/word get/any '>file [
        block! [
            .block: :>file
            .file: to-red-file form .block/1
            .target: to-red-file form .block/2
            .commit-script-folder: to-red-file form .block/3     
        ]
    ][
        .file: to-red-file form :>file
        .target: to-red-file form :>target
        .commit-script-folder: to-red-file form >commit-script-folder
    ]

    copy-file/force .file .target
    .cd (.commit-script-folder)
    either exists? %commit.red [
        do %commit.red
    ][
        print [{Create a %commit.red script inside} (.commit-script-folder) {to run for commit / push to remote repository}]
    ]
    
]

.alias .deploy [deploy]
