Red [
    Title: ".system.coder.apps.git.archive.red"
    Infos: [
        https://davidwalsh.name/create-repository-archive-git
        http://minhajuddin.com/2016/01/10/how-to-get-a-git-archive-including-submodules/
        http://alblue.bandlem.com/2011/09/git-tip-of-week-git-archive.html
    ]
    Builds: [
        0.0.0.1.4 {Initial version}
    ]
]

.git-archive:  function[>source-folder >zip-path ][

    {Usage:
        .git-archive "C:\rebol\.system.user\.data\.activities\redlang.red\.github" 
        "C:\rebol\.system.user\.data\.activities\redlang.red\.github\.github.zip"
    }

    either file? >source-folder [
        local-source-folder: to-local-file >source-folder
    ][
        local-source-folder: >source-folder
    ]

    either file? >zip-path [
        local-zip-path: to-local-file >zip-path
    ][
        local-zip-path: >zip-path
    ]

    unless value? '.string-expand [
        do https://redlang.red/string-expand
    ]

    command-template: {set-location '<%folder%>';git archive --format zip --output <%zip-path%> master}
    command: .expand command-template [
        folder: (local-source-folder)
        zip-path: (local-zip-path)
    ]

    unless value? '.call-powershell [
        do https://redlang.red/call-powershell.red
        ;do %../libs/call-powershell.3.red
    ]

    print "starting..."
    unless error? try [
        .call-powershell/out command
    ] [
        print [>zip-path "created."]
        return >zip-path
    ]
    return false
]

.git.archive: :.git-archive
git.archive: :.git-archive
.git.export: :.git-archive
git.export: :.git-archive


