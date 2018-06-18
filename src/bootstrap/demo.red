Red [
    Title: "demo.red"
]

do read http://redlang.red/do-trace
do read http://redlang.red/bootstrap.red

create-bootstrap-page ; create a bootstrap page
bootstrap-title "Hello Bootstrap" ; boostrap title is "Hello Boostrap" or add a bootstrap title
bootstrap-nav ; add or create a bootstrap nav

insert-div 'container
insert-div/within 'container 'row 
insert-div/within 'row "col-md-6 col-md-offset-3" 

write %bootstrap-demo.html it
