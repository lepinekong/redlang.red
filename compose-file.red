Red [
    Title: "compose-file.red"
]

compose-file: function [target-file components][
    content: copy []
    forall components [
        component: components/1
        append content component
    ]
    write target-file rejoin compose content
    return rejoin compose content
]