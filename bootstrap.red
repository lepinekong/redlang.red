Comment {
    Requirements: [
        Redlang: https://www.red-lang.org 
        {or paste this oneliner in powershell: https://gist.github.com/lepinekong/d895d64528ee85e6aac4b13bdf3437bc}
        VSCode: (optional) https://code.visualstudio.com/
        VSCode-Extension: (optional) https://marketplace.visualstudio.com/items?itemName=red-auto.red
    ]  

    Demo: {
        type in red console:
        do read https://gist.githubusercontent.com/lepinekong/31223dda30fd28fc61c686f7780c6962/raw/656b1fc727d12ae6381ca61252a513deb8deafc0/Bootstrap.Code.Generation.red
    }  
}

Red [
    Title: "bootstrap.red"
    Url: http://redlang.red/bootstrap.red
    Github-Url: https://gist.github.com/lepinekong/31223dda30fd28fc61c686f7780c6962
    History: [
        v0.8: {Nav-Bar component}
    ]
    TODO: [
        - Jumbotron
        - Background Image
        - ...
    ]
]

do read http://redlang.red/html5.red

emit-nav: function[/inverse /rounded-corner][

    html: copy {}

    snippet: {<nav class="navbar navbar-default navbar-static-top">
    </nav>}

    if inverse [
        snippet: {<nav class="navbar navbar-inverse navbar-static-top">
    </nav>}        
    ]

    if rounded-corner [
        replace/all snippet " navbar-static-top" ""
    ]

    append html snippet
    return html
]

emit-container: function[html /fixed][
    container: {<div class="container-fluid">}
    if fixed [
        container: {<div class="container">}
    ]
    container: rejoin [newline tab container]
    append container {
    </div>}
    parse html [thru {<nav class="navbar} thru {>} mark: (insert mark container)]
    return html
]

emit-navbar-header: function[html .brand [word! string! block!]][
    either block? .brand [
        WebSiteName: .brand/1
        Url: .brand/2
    ][
        WebSiteName: form .brand
        Url: "#"
    ]
    navbar-header: {
        <div class="navbar-header">
            <a class="navbar-brand" href="%url%">%WebSiteName%</a>
        </div>} 
        replace/all navbar-header {%WebSiteName%} WebSiteName
        replace/all navbar-header {%url%} Url
    parse html [thru {<div class="container} thru {>} mark: (insert mark navbar-header)]    
    return html
]

emit-navbar-nav: function[html menu-options][
    navbar-nav: {
        <ul class="nav navbar-nav">
        </ul>}

    reverse menu-options
    forall menu-options [
        menu-option: menu-options/1
        menu-option-string: rejoin [newline tab tab
            {<li><a href="#">Page 1</a></li>}]
        replace/all menu-option-string "Page 1" menu-option/1
        replace/all menu-option-string "#" menu-option/2
        parse navbar-nav [
            thru {<ul class="nav navbar-nav">} mark:
            (insert mark menu-option-string)
        ]
    ] 

    parse html [thru {<div class="container} 
    thru {</div>} mark: (insert mark navbar-nav)]
    return html
]

emit-navbar-search: function[html][
    snippet: {            
        <form class="navbar-form navbar-left">
            	<div class="input-group">
                    <input type="text" class="form-control" placeholder="Search">
                    <span class="input-group-btn">
                        <button type="button" class="btn btn-default"><span class="glyphicon glyphicon-search"></span></button>
                    </span>
                </div>
            </form>
            }

    parse html [thru {<div class="container} 
    thru {</div>} to {</div>} mark: (insert mark snippet)]
    return html            
]

emit-navbar-dropdown-menu: function[html .dropdown-menu][

    title: .dropdown-menu/1/1
    link: .dropdown-menu/1/2

    navbar-nav: {<li class="dropdown">
        <a data-toggle="dropdown" class="dropdown-toggle" href="%link%">%title%<b class="caret"></b></a>
        <ul class="dropdown-menu">
        </ul>
        </li>}
    replace/all navbar-nav "%title%" title
    replace/all navbar-nav "%link%" link

    menu-options: reverse (skip .dropdown-menu 1)
    forall menu-options [
        menu-option: menu-options/1

        either menu-option = 'Divider [
            menu-option-string: rejoin [newline tab tab {<li class="divider"></li>}]
        ][
            menu-option-string: rejoin [newline tab tab
                {<li><a href="#">Page 1</a></li>}]
            replace/all menu-option-string "Page 1" menu-option/1
            replace/all menu-option-string "#" menu-option/2
        ]

        parse navbar-nav [
            thru {<ul class="dropdown-menu">} mark:
            (insert mark menu-option-string)
        ]
    ] 

    parse html [thru {<ul class="nav navbar-nav">} 
    to {</ul>} mark: (insert mark navbar-nav)]
    return html
]

Bootstrap.Nav.Gen: function [
    .brand [word! string! block!] 
    .menu-options [block!]
    /Dropdown-Menu .dropdown-menu [block!]
    /Search-Bar
    /rounded-corner
    /inverse
][  

    code: "emit-nav"
    if inverse [
        append code "/inverse"
    ]
    if rounded-corner [
        append code "/rounded-corner"
    ]
    html: do code ; white by default

    html: emit-container/fixed html ; fluid by default
    html: emit-navbar-header html .brand
    html: emit-navbar-nav html .menu-options
    if Dropdown-Menu [
        html: emit-navbar-dropdown-menu html .dropdown-menu
    ]    
    if Search-Bar [
        html: emit-navbar-search html
    ]
    append html newline
    return html
]

Bootstrap.Page.Gen: function[
        .html5 [string!]
        /title .title [string!]
        /nav-bar .nav-bar
        /insert-body .body [string!]
        /insert-head .head [string!]
    ][
    html5: .html5 

    if title [
        parse html5 [
            thru {<title} thru {>} start: to {</title>} end: (
                change/part start "" end
                insert start .title
            )
        ]
    ]

    if nav-bar [
        parse html5 [to {</body>} mark: (insert mark .nav-bar)]
    ]

    if insert-body [
        parse html5 [to {</body>} mark: (insert mark .body)]
    ]

    if insert-head [
        parse html5 [to {</head>} mark: (insert mark .head)]
    ]

    return html5

]

html.compose: function [
    .html5 [string!] 
    /insert .html 
    /insert-div .div-class 
    /within-div .within-div
    /tab .ntab
    ][

    tab-refinement: tab
    tab: system/words/tab 
    insert-refinement: insert
    insert: get in system/words 'insert

    html5: .html5 

    ntabs: copy ""
    if tab-refinement [
        loop .ntab [append ntabs tab]
    ]    

    if insert-div [

        div-class: rejoin [newline ntabs {<div class="} .div-class {">} newline ntabs {</div>}]

        either within-div [
            within-div-partial: rejoin [{<div class="} .within-div]
            parse html5 [
                thru within-div-partial thru ">" start: (
                    insert start div-class 
                ) 
            ]

        ][
            append html5 div-class
        ]
        return html5
    ]

    if insert-refinement [
        
        if within-div [
            within-div-partial: rejoin [{<div class="} .within-div]
            parse html5 [
                thru within-div-partial thru ">" start: (
                    insert start .html
                ) 
            ]  
            return html5      
        ]
    ]

]
