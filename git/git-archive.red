Red [
    Title: ".system.coder.apps.git.archive.red"
    Infos: [
        https://davidwalsh.name/create-repository-archive-git
        http://minhajuddin.com/2016/01/10/how-to-get-a-git-archive-including-submodules/
        http://alblue.bandlem.com/2011/09/git-tip-of-week-git-archive.html
    ]
]

.git-archive:  function[>source-folder >zip-path][

    {Usage:
        .git.archive (.system.coder.path)
    }

    do https://redlang.red/datetime.red

    command: {set-location '<%folder%>';git archive --format zip --output <%zip-path%> master}

    print "starting..."

    do https://redlang.red/string-expand
    do https://redlang.red/call-powershell

    change-dir (>source-folder)
    .call-powershell/out .expand command [
        folder: (to-string (to-local-file folder))
        zip-path: (>zip-path)
    ]
    print "finished."

]

.git.archive: :app.git.archive
git.archive: :app.git.archive
.git.export: :app.git.archive
git.export: :app.git.archive


