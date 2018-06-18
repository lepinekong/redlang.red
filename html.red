Red [
    Title: "html5.red"
]

do read http://redlang.red/do-trace

html5-template: {
<!doctype html>

<html lang="fr">
    <head>
    <meta charset="utf-8">

    <title>Hello World</title>
    <meta name="description" content="The HTML5 Herald">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="author" content="me">

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

	<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" />
	<link href='http://fonts.googleapis.com/css?family=Abel|Open+Sans:400,600' rel='stylesheet'>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.0/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
    <!--[if lt IE 9]>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/html5shiv/3.7.3/html5shiv.js"></script>
    <![endif]-->
    </head>

    <body>
        <script src=""></script>
    </body>
</html>    
}

html.page.create: function[/language .language][
    html5: copy html5-template
    if language [
        parse-rule: [
            thru {<html lang="} mark-start: to {"} mark-end: 
            (change/part mark-start .language mark-end)
        ]
        parse html5 parse-rule
    ]
    system/words/it: .html.compose html5
]

create-html-page: :html.page.create

.div.insert:  function['.class [word! lit-word! string!] /within '.class-parent [word! lit-word! string!] /local ][
    switch/default type?/word get/any '.class [
        unset! [

        ]
        string! word! lit-word! [

            class: form .class

            either within [
                class-parent: form .class-parent

                old-class: class
                old-parent: class-parent
                
                class-parent: old-class
                class-child: old-parent
                
                ; do-trace 64 [
                ;     ;print "line 64"
                ;     ?? class-parent
                ;     ?? class-child
                ; ] %html.red

                return system/words/it: html.compose/insert-div/within-div/tab system/words/it class-child class-parent 3
            ][
                return system/words/it: html.compose/insert-div/tab system/words/it class 2
            ]

            
        ]
    ] [
        throw error 'script 'expect-arg .html
    ]
]
.insert-div: :.div.insert
insert-div: :.div.insert


.html.compose: function [
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
            either find html5 "</body>" [
                parse html5 [
                    to "</body>" start: (
                        insert start rejoin [
                            div-class 
                            newline
                        ]
                    )
                ]
            ][
                append html5 div-class
            ]
            
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

    return html5
]

html.compose: :.html.compose

.append-head: function[.html5 >snippet /style][
    snippet: >snippet

    snippet: {    <style type="text/css">
        body { background: navy !important; } /* Adding !important forces the browser to overwrite the default style applied by Bootstrap */
    </style>}


] 

;--------------

.insert-before-tag: function[/html >html /tag >before-tag /snippet >snippet /to-file >file-path /to-clipboard][
    
    
    either html [
        .html: >html
    ][
        .html: system/words/it
    ]

    parse .html [
        to >before-tag start: (
            insert start rejoin [
                >snippet 
                newline
            ]
        )
    ]

    ;------------------------------------

    html>: .html

    if to-clipboard [
        write-clipboard html>
    ]
    if to-file [
        write >file-path html>
    ]

    system/words/it: html>
    return html>
]

.insert-css-style: function[/snippet >css-style /html >html /to-file >file-path /to-clipboard][


    either html [
        .html: >html
    ][
        .html: system/words/it
    ]

    {Example:
        test: .insert-css-style html5-template {body { background: navy !important; } }
    }
    snippet: rejoin [
    {<style type="text/css">}
    newline        
        >css-style
    newline
    {   </style>}
    ]

    .html: .insert-before-tag/html/tag/snippet >html "</head>" snippet

    ;------------------------------------

    html>: .html

    if to-clipboard [
        write-clipboard html>
    ]
    if to-file [
        write >file-path html>
    ]

    system/words/it: html>
    return html>
]
insert-css-style: :.insert-css-style

test: .insert-css-style/html/snippet/to-clipboard html5-template {body { background: navy !important; } }  




