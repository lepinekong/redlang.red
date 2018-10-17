Red [
    Title: ""
    Builds: [
        0.0.0.1.01.8 {
            - config buggy to fix
        }
    ]
]

if not value? '.redlang [
    do https://redlang.red
]
.redlang [call-powershell expand-string make-dir alias]

.download: function [
    {
        Examples:
        - .download https://aka.ms/win32-x64-user-stable D:\Download
        - .download/subfolder https://aka.ms/win32-x64-user-stable D:\Download test
    }
    >url
    >folder
    /subfolder '>subfolder
][

    >folder: form >folder

    unless subfolder [
        >subfolder: ""
    ]
    >subfolder: form >subfolder

    local>download-path: to-red-file rejoin [>folder >subfolder]
    if not exists? local>download-path [
        make-dir (local>download-path)
        print [{creating folder} (local>download-path)]
    ]
        

    oneline-powershell: {Function Get-RedirectedUrl {Param ([Parameter(Mandatory=$true)][String]$url);$request = [System.Net.WebRequest]::Create($url);$request.AllowAutoRedirect=$false;$response=$request.GetResponse();If ($response.StatusCode -eq "Found"){$response.GetResponseHeader("Location")}};function downloadFile {param ([string]$url,[string]$folder,[string]$subFolder);[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12;$webRequest = [net.WebRequest]::Create($url);$uri = $webrequest.GetResponse().ResponseUri.Segments;[string]$fileName=$uri[3];if ([string]::IsNullOrEmpty($FileName)) {$FileName = [System.IO.Path]::GetFileName((Get-RedirectedUrl "$url"))};$target_folder="$folder\$subFolder";[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12;$Webcli=New-Object System.Net.WebClient;if (!(Test-Path `"$target_folder\$fileName`")) {$Webcli.DownloadFile("$url","$target_folder\$fileName")}}}
    oneline-powershell: rejoin [
        oneline-powershell
        ";"
        .expand-string {downloadFile -url "<%url%>" -folder "<%folder%>" -subFolder "<%subfolder%>"} [
                url: (>url)
                folder: (>folder)
                subfolder: (>subfolder)
        ]
    ] 

    ; TODO: alternative use curl if it doesn't work or on linux
    .call-powershell/out oneline-powershell

]

download: function [
    'param>url [word! string! file! url!] 
    'param>download-folder [word! string! file! url! unset!] 
    /_build {Build number for developer}
    /silent {don't print message on console}   
    /_debug {debug mode} 
][

    >builds: 0.0.0.0.1.1

    if _build [
        unless silent [
            print >builds
        ]
        return >builds
    ]

    switch/default type?/word get/any 'param>download-folder [
        unset! [
            param>config-file: %download.config.red
            param>log-filename: %download.log 
            either exists? param>config-file [
                external>config: load param>config-file
            ][
                param>download-folder: request-dir/dir (what-dir)
                if none? param>download-folder [
                    print "abort download."
                    return false
                ]
                external>config: copy []
                ;append config reduce [download-folder: (param>download-folder)] ; BUG
                append external>config reduce [(to-set-word 'download-folder) (param>download-folder)]
                ;object>config: context config
                save (param>config-file) external>config
            ]
        ]
        word! string! file! url! block! [
            param>download-folder: to-red-file form param>download-folder
            .download (param>url) (param>download-folder) 
        ]
    ] [
        throw error 'script 'expect-arg param>url
    ]
]




