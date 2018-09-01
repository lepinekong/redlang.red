Red [
    Title: ""
]

.request-dir: function [
    /title '>title
    /dir '>dir
][
    unless title [
        >title: {request dir}
    ]
    .title: :>title

    unless dir [
        >dir: %./
    ]

    if not dir? >dir [
        >dir: to-red-file form :>dir
    ]
    .dir: :>dir

    return request-dir/title/dir .title to-local-file clean-path .dir
]
