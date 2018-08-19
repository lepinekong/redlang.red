Red [
    Title: "ci.red"
]

msg: {templating.red}

do https://quickrun.red/git-commit
do https://redlang.red/cd

cd %../
print {push to remote github}
commit msg
if not exists? %cd.txt [write %cd.txt ""]
write/append/lines %cd.txt rejoin [now { - } msg]

