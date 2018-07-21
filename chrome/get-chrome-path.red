Red [
    Title: "get-chrome-path.red"
]

get-chrome-path: function [][
    return chrome-path: rejoin [{"} get-env "programfiles(x86)" "\Google\Chrome\Application\chrome.exe" {"}]
]