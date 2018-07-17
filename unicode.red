Red [
	Author: "Toomas Vooglaid"
	Date: 2017-12-16
    Original-Url: https://gist.github.com/toomasv/e819fa2452f38a15cea6e20182ab9309
	Needs: %range.red
	Needs-Gist: https://gist.github.com/toomasv/0e3244375afbedce89b3719c8be7eac0
]

sysdo: :do
do: function [lib][
	try [sysdo lib]
]

do %toomasv/range.red
do %toomasv/unicode.red

emoticons: unicode 'emoticons
?? emoticons


