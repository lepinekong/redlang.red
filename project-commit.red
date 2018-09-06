Red [
    Title: ""
]

if not value? '.redlang [
    do https://redlang.red
]
.redlang [cd git-commit log confirm]

project-commit: function [>folder][

    if not value? '>commit-message [
        >commit-message: ask "commit message: "
    ]

    msg: rejoin [{prod env} { - } >commit-message]


    log %commit.log msg

    cd (>folder)
    print ["Commit & Push to " (>folder)]
    print what-dir

    commit (msg)

    if confirm {commit to global repository?} [
        print "starting committing to global repository..."
        cd %../
        cd .ci
        do %commit.red
        print "finished committing to global repository."
    ]

]