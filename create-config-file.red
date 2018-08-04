Red [
    Title: "create-config-file.red"
]

Create-Config-File: function [>name][
    >name: form >name
    make-dir %config/
    file-path: rejoin [%config/ >name %.config.read]
    if not exists? file-path [
        write file-path ""
    ]
]