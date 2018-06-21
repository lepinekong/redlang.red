Red [
    Title: "file-io.red"
]

.create-folder: function[>folder][
    folder: >folder
    if not exists? red-folder: to-red-file folder [
        make-dir/deep red-folder
    ]  
    return >folder
]

.write: function[][
    
]