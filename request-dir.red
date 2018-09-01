Red [
    Title: "request-dir.red"
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
    .dir: to-local-file clean-path :>dir

    request-dir/title/dir (.title) (.dir)
]