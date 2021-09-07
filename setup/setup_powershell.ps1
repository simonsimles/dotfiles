$gitBaseFolder = Split-Path $PSScriptRoot
Write-Host $gitBaseFolder
New-Item -ItemType SymbolicLink -Path "$HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1" -Value "$($gitBaseFolder)\PowerShell\Microsoft.PowerShell_profile.ps1"
