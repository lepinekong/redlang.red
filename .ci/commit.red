Red [
    Title: "ci.red"
]

msg: {templating.red}

do https://quickrun.red/git-commit
do https://redlang.red/cd

cd %../
commit msg
print {push to remote github}
write/append/lines %cd.txt rejoin [now { - } msg]
