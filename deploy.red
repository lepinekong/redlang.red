Red [
    Title: ""
]

if not value? '.redlang [
    do https://redlang.red
]
.redlang [cd copy-files git-commit]

.deploy: function [
    '>file 
    '>target 
    '>commit-script-folder
][
    do http://redlang.red/do-trace
    do-trace 15 [
        ?? >file
        ?? >target
        ?? >commit-script-folder
    ] %deploy.1.red
    

    .file: to-red-file form :>file
    .target: to-red-file form :>target
    .commit-script-folder: to-red-file form >commit-script-folder

    copy-file/force .file .target
    .cd (.commit-script-folder)
    either exists? %commit.red [
        do %commit.red
    ][
        print [{Create a %commit.red script inside} (.repo) {to run for commit / push to remote repository}]
    ]
    
]

.alias .deploy [deploy]
