Red [
    Title: "ci.red"
]

msg: {call powershell.html}

do https://quickrun.red/git-commit
do https://redlang.red/cd

print {push to remote github}
write/append/lines %cd.txt rejoin [now { - github - } msg]
cd %../
commit (msg)
