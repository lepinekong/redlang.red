Red [
    Title: "ci.red"
]

msg: {templating.red}

do https://quickrun.red/git-commit
do https://redlang.red/cd

print {push to remote github}
; if not exists? %cd.txt [write %cd.txt ""]
write/append/lines %cd.txt rejoin [now { - github - } msg]
cd %../
commit msg


