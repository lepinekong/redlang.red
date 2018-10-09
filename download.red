Red [
    Title: ""
    Notes: [
        {Fixed bug with:
[string]::IsNullOrEmpty($FileName)
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
        

    oneline-powershell: {Function Get-RedirectedUrl {Param ([Parameter(Mandatory=$true)][String]$url);$request = [System.Net.WebRequest]::Create($url);$request.AllowAutoRedirect=$false;$response=$request.GetResponse();If ($response.StatusCode -eq "Found"){$response.GetResponseHeader("Location")}};function downloadFile {param ([string]$url,[string]$folder,[string]$subFolder);[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12;$webRequest = [net.WebRequest]::Create($url);$uri = $webrequest.GetResponse().ResponseUri.Segments;[string]$fileName=$uri[3];if ([string]::IsNullOrEmpty($FileName)) {Write-Host "FileName is empty";$FileName = [System.IO.Path]::GetFileName((Get-RedirectedUrl "$url"));Write-Host "FileName is no more empty: $FileName"};$target_folder="$folder\$subFolder";[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12;$Webcli=New-Object System.Net.WebClient;if (!(Test-Path `"$target_folder\$fileName`")) {$Webcli.DownloadFile("$url","$target_folder\$fileName")}}}
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

alias .download [download]

