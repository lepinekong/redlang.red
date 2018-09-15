Red [
    Title: ""
]

if not value? '.redlang [
    do https://redlang.red
]
.redlang [call-powershell expand-string alias]

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

    oneline-powershell: {function downloadFile {param ([string]$url,[string]$folder,[string]$subFolder);[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12;$webRequest = [net.WebRequest]::Create($url);$uri = $webrequest.GetResponse().ResponseUri.Segments;[string]$fileName=$uri[3];;$target_folder="$folder\$subFolder";[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12;$Webcli=New-Object System.Net.WebClient;if (!(Test-Path `"$target_folder\$fileName`")) {$Webcli.DownloadFile("$url","$target_folder\$fileName")}}}
    oneline-powershell: rejoin [
        oneline-powershell
        ";"
        .expand-string {downloadFile -url "<%url%>" -folder "<%folder%>" -subFolder "<%subfolder%>"} [
                url: (>url)
                folder: (>folder)
                subfolder: (>subfolder)
        ]
    ] 
    .call-powershell/out oneline-powershell

]

alias .download [.download]

