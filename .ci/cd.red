Red [
    Title: "ci.red"
]

file: %call-powershell.html
msg: rejoin [file { } "updated."]

do https://quickrun.red/git-commit
do https://redlang.red/cd

print {push to remote github}
write/append/lines %cd.txt rejoin [now { - github - } msg]
cd %../
commit (msg)

ask "pause..."

write-clipboard read rejoin [https://redlang.red/ file]
