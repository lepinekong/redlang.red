Red [
    Title: ""
]

.Red.Func.override: function['.func-name][

    Context [
        func-name: form .func-name
        func-src: get :.func-name
        spec: mold/only spec-of :func-src
        template: {if not value? 'sys<%func-name%> [
    sys<%func-name%>: :<%func-name%>
    <%func-name%>: function [<%spec%>][

    ]  
]      
}
        .out: build-markup/bind template self
        write-clipboard .out
    ]

]

Red.Func.override: :.Red.Func.override
override: :.Red.Func.override