Red [
    Title: "redlang-with-style-01.red"
]

Article: [

    Title: {redlang-with-style-01.red}

    Step-1: [
        .title: {}
        .text: {
        }
        .text: {Example:}
        .code: {
Red [
    Title: "_config.red"
]

; customize for your own blog:
blog-properties: {
title: Welcome to My Bookmarks
description: MyBookmarks.Space
}

;instead of these two lines of code
;config-file: %_config.yml
;config: read config-file

;you can read and declare the file at once:
config: read (config-file: %_config.yml)
;or even (but less readable):
;config: read config-file: %_config.yml


unless find config "title" [
    append config blog-properties
    write config-file config
]
            
        }
    ]
]