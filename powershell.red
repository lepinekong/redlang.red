Red [
    Title: "powershell.red"
]

powershell.profile: function [][
	;USERNAME: get-env "username"
	;call/show rejoin [{notepad.exe C:\Users\} USERNAME {\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1}]
    USERPROFILE: get-env "USERPROFILE"
	call/show rejoin [{notepad.exe } {"} USERPROFILE {\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1} {"}]
]
powershell-profile: :powershell.profile
