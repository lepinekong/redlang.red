Red [
    Title: "ci.red"
]

file: %index.red
msg: rejoin [file { } "fixed."]

do https://quickrun.red/git-commit
do https://redlang.red/cd

print {push to remote github}
write/append/lines %commit.txt rejoin [now { - github - } msg]
cd %../
commit (msg)

ask "pause..."

write-clipboard read rejoin [https://redlang.red/ file]
