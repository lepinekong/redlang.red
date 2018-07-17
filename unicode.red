Red [
	Author: "Toomas Vooglaid"
	Date: 2017-12-16
    Original-Url: https://gist.github.com/toomasv/e819fa2452f38a15cea6e20182ab9309
	Needs: %range.red
	Needs-Gist: https://gist.github.com/toomasv/0e3244375afbedce89b3719c8be7eac0
]

sysdo: :do
do: function [lib][
	try [sysdo lib] ; to avoid error in toomasv/unicode.red with do %range.red
]

do https://redlang.red/toomasv/range.red
do https://redlang.red/toomasv/unicode.red


emoticons: unicode 'emoticons
?? emoticons


