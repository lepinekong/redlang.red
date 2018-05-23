Red [
    Title: "demo.red"
]

do %../do-trace.red
do %../html.red

create-html-page
insert-div 'container
insert-div/within 'container 'row 
insert-div/within 'row "col-md-6 col-md-offset-3" 

do-trace 10 [
    write-clipboard it
    ?? it
] %demo.red

