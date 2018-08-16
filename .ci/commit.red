Red [
    Title: "commit.red"
]

do https://quickrun.red/git-commit
do https://redlang.red/cd
cd %../
commit {c override.html}
ask "pause..."
write-clipboard read https://redlang.red/override.html
