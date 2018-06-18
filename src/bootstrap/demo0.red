Red [
    Title: "Bootstrap demo"
]

do read http://redlang.red/bootstrap.red

html-content: {<h1 class="margin-base-vertical">Subscribe:</h1>
				<form class="margin-base-vertical">
					<p class="input-group">
						<span class="input-group-addon"><span class="fa fa-envelope"></span></span>
						<input type="text" class="form-control input-lg" name="email" placeholder="jonsnow@knowsnothi.ng" />
					</p>
					<p class="help-block text-center"><small>We won't send you spam. Unsubscribe at any time.</small></p>
					<p class="text-center">
						<button type="submit" class="btn btn-success btn-lg">Keep me posted</button>
					</p>
					</span>
				</form>}

css-style: {
	<style>
		body {padding-top: 0px; font-size: 16px; font-family: "Open Sans",serif;}
		h1 {font-family: "Abel", Arial, sans-serif; font-weight: 400; font-size: 40px;}
		.margin-base-vertical {margin: 40px 0;}
	</style>   
}

; Data in ReAdABLE Human Format (see https://lepinekong.github.io)
brand: ["Navbar with Search-Bar" https://getbootstrap.com/]
menu-options: [ [Home "#"] ["Page 1" "#"] ["Page 2" "#"] ["Page 3" "#"] ]
dropdown-menu: [ ["More Info" "#"] ["Info 1" "#"] ["Info 2" "#"] Divider ["Info 3" "#"] ]

Bootstrap-Nav: Bootstrap.Nav.Gen/Search-Bar/Dropdown-Menu ; also available: /inverse /rounded-corner
brand menu-options dropdown-menu; Search-Bar and dropdown list data parameters

html-body: {}
html-body: html.compose/insert-div/tab html-body "container" 1
html-body: html.compose/insert-div/within-div/tab html-body "row" "container" 2
html-body: html.compose/insert-div/within-div/tab html-body "col-md-6 col-md-offset-3" "row" 3
html-body: html.compose/insert/within-div html-body html-content "col-md-6 col-md-offset-3"

Bootstrap-Page: Bootstrap.Page.Gen/title/nav-bar html5-template "Bootstrap Page" Bootstrap-Nav
Bootstrap-Page: Bootstrap.Page.Gen/title html5-template "Bootstrap Page"
Bootstrap-Page: Bootstrap.Page.Gen/insert-body Bootstrap-Page html-body
Bootstrap-Page: Bootstrap.Page.Gen/insert-head Bootstrap-Page css-style

delete %index.html
print "Output to %index.html"
write %index.html Bootstrap-Page
