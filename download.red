Red [
    Title: "TODO: fix explorer bug"
    Builds: [
        0.0.0.1.02.2 {return path of downloaded file}
        0.0.0.1.01.25 {minor refactoring for _debug}
        0.0.0.1.01.24 {fixed opens download folder if still bug due to explorer.red}
        0.0.0.1.01.17 {fix opens download folder if still bug due to explorer.red}
        0.0.0.1.01.16 {opens download folder} 
        0.0.0.1.01.15 {
            - config bug fixed
        }        
        0.0.0.1.01.8 {
            - config buggy to fix
        }
    ]
    TODO: [
        1 {select file in download folder}
        2 {CD/Bookmark}
        3 {alternative use curl if it doesn't work or on Linux}
    ]
]

if not value? '.redlang [
    do https://redlang.red
]
.redlang [call-powershell expand-string make-dir alias log join]
.quickrun [explorer]

.download: function [
    {
        Examples:
        - .download https://aka.ms/win32-x64-user-stable D:\Download
        - .download/subfolder https://aka.ms/win32-x64-user-stable D:\Download test
    }
    >url
    /folder >folder
    /subfolder '>subfolder
    /no-explorer ; doesn't not open explorer
    /_build
    /_debug
    /silent
][

    >builds: [
        0.0.0.1.02.15 {debug message}
        0.0.0.1.01.24 {fixed opens download folder if still bug due to explorer.red}        
    ]

    if _build [
        unless silent [
            print >builds
        ]
        return >builds
    ]     

    if _debug [
        do https://redlang.red/do-trace
    ]

    const>config-file: %download.config.red
    const>log-filename: %download.log 
    either exists? const>config-file [
        external>config: load const>config-file
        param>download-folder: external>config/download-folder
    ][
        param>download-folder: request-dir/dir (what-dir)
        if none? param>download-folder [
            print "abort download."
            return false
        ]
        external>config: copy []
        
        append external>config reduce [
            (to-set-word 'download-folder) 
            (to-local-file param>download-folder)
        ]
        ;object>config: context config
        save (const>config-file) external>config

    ]

    unless folder [
        >folder: to-local-file to-red-file form param>download-folder
    ]
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
        
    >folder: to-local-file >folder ; added in download.13
    >subfolder: to-local-file >subfolder ; added in download.13

    oneline-powershell: {Function Get-RedirectedUrl {Param ([Parameter(Mandatory=$true)][String]$url);$request = [System.Net.WebRequest]::Create($url);$request.AllowAutoRedirect=$false;$response=$request.GetResponse();If ($response.StatusCode -eq "Found"){$response.GetResponseHeader("Location")}};function downloadFile {param ([string]$url,[string]$folder,[string]$subFolder);[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12;$webRequest = [net.WebRequest]::Create($url);$uri = $webrequest.GetResponse().ResponseUri.Segments;[string]$fileName=$uri[3];if ([string]::IsNullOrEmpty($FileName)) {$FileName = [System.IO.Path]::GetFileName((Get-RedirectedUrl "$url"))};$target_folder="$folder\$subFolder";[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12;$Webcli=New-Object System.Net.WebClient;if (!(Test-Path `"$target_folder\$fileName`")) {$Webcli.DownloadFile("$url","$target_folder\$fileName");Write-Host "$target_folder\$fileName"}}}
    oneline-powershell: rejoin [
        oneline-powershell
        ";"
        .expand-string {downloadFile -url "<%url%>" -folder "<%folder%>" -subFolder "<%subfolder%>"} [
                url: (>url)
                folder: (>folder)
                subfolder: (>subfolder)
        ]
    ] 

    either _debug [
        file-path>out: .call-powershell/out/silent/_debug oneline-powershell
    ][
        file-path>out: .call-powershell/out/silent oneline-powershell
    ]
    

    if _debug [
        do-trace 120 [
            ?? file-path>out
        ] %download.15.red
    ]

    while [find file-path>out "\\"][
        replace/all file-path>out "\\" "\"
    ] 
    replace/all file-path>out "^/" ""    

    .log (const>log-filename) (.join [>url "-" file-path>out])

    unless no-explorer [
        local>download-folder: rejoin [>folder "\" >subfolder]
        either _debug [
            .explorer/_debug (local>download-folder)
        ][
            .explorer (local>download-folder)
        ]
        
    ]

    if _debug [
        ;do http://redlang.red/do-trace
        do-trace 130 [
            ?? file-path>out
        ] %download.15.red
        
    ]
    return file-path>out
]

download: function [
    'param>url [word! string! file! url!] 
    'param>download-folder [word! string! file! url! unset!] 
    /no-explorer ; doesn't not open explorer
    /_build {Build number for developer}
    /silent {don't print message on console}   
    /_debug {debug mode} 
][

    >builds: [
        0.0.0.1.01.24 {fixed opens download folder if still bug due to explorer.red}        
    ]

    if _build [
        unless silent [
            print >builds
        ]
        return >builds
    ]

    switch type?/word get/any 'param>download-folder [
        unset! [
            ; const>config-file: %download.config.red
            ; const>log-filename: %download.log 
            ; either exists? const>config-file [
            ;     external>config: load const>config-file
            ;     ; FORGOT to set param>download-folder in download.11.red !!!
            ;     param>download-folder: external>config/download-folder
            ; ][
            ;     param>download-folder: request-dir/dir (what-dir)
            ;     if none? param>download-folder [
            ;         print "abort download."
            ;         return false
            ;     ]
            ;     external>config: copy []
                
            ;     append external>config reduce [
            ;         (to-set-word 'download-folder) 
            ;         (to-local-file param>download-folder)
            ;     ]
            ;     ;object>config: context config
            ;     save (const>config-file) external>config

            ; ]
            return .download (:param>url) ; 16: fixed bug doesn't exist
        ]
        word! string! file! url! block! [
            ;param>download-folder: to-red-file form param>download-folder
            ;.download (param>url) (param>download-folder) 
        ]
    ]

    param>download-folder: to-local-file to-red-file form param>download-folder

    either _debug [
        downloaded-file>: .download/folder/_debug (param>url) (param>download-folder)
    ][
        downloaded-file>: .download/folder (param>url) (param>download-folder)
    ]
    ;.log %download.log (rejoin [param>url " - " downloaded-file>])
    return downloaded-file>
     
]




