Red [
    Title: "html5.red"
]

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