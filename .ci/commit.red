Red [
    Title: "commit.red"
]

do https://quickrun.red/git-commit
do https://redlang.red/cd
cd %../
commit {f do-html-embed.html c do-embed-html}
ask "pause..."
write-clipboard read https://redlang.red/do-html-embed.html
