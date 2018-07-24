Red [
    Title: ".system.coder.apps.git.archive.red"
    Infos: [
        https://davidwalsh.name/create-repository-archive-git
        http://minhajuddin.com/2016/01/10/how-to-get-a-git-archive-including-submodules/
        http://alblue.bandlem.com/2011/09/git-tip-of-week-git-archive.html
    ]
]

.git-archive:  function[>source-path [file!] >zip-path [file!][

    {Usage:
        .git.archive (.system.coder.path)
    }

    target-directory: <=target-directory

        folder: form .folder
        folder: .cd (folder)
        short-filename: (last (split folder "/"))
        string-date: .get-string-date
        command: {set-location '<%folder%>';git archive --format zip --output <%target-directory%><%short-filename%>_<%string-date%>.zip master}

        print "starting..."
        .call-powershell/out .expand command [
            target-directory: (to-string target-directory)
            short-filename: (to-string short-filename)
            folder: (to-string (to-local-file folder))
            string-date: (string-date)
        ]
            print "finished."

]

.git.archive: :app.git.archive
git.archive: :app.git.archive
.git.export: :app.git.archive
git.export: :app.git.archive


