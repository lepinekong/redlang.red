Red [
    Title: "commit.red"
]

do https://quickrun.red/git-commit
do https://redlang.red/cd
cd %../
commit {f templating.6.red}
;ask "pause..."
;write-clipboard read https://redlang.red/do-html-embed.html
