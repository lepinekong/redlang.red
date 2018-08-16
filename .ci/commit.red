Red [
    Title: "commit.red"
]

do https://quickrun.red/git-commit
do https://redlang.red/cd
cd %../
commit {u dot.do.red: clean update}
ask "pause..."
write-clipboard read https://redlang.red/dot.do.red
