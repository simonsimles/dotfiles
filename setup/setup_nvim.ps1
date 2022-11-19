$gitBaseFolder = Split-Path $PSScriptRoot
Write-Host $gitBaseFolder
New-Item -ItemType SymbolicLink -Path "$HOME\AppData\Local\nvim\init.lua" -Value "$($gitBaseFolder)\nvim\init.lua"
New-Item -ItemType SymbolicLink -Path "$HOME\AppData\Local\nvim\lua" -Value "$($gitBaseFolder)\nvim\lua"
New-Item -ItemType SymbolicLink -Path "$HOME\AppData\Local\nvim\ftplugin" -Value "$($gitBaseFolder)\nvim\ftplugin"
New-Item -ItemType SymbolicLink -Path "$HOME\AppData\Local\nvim\ftdetect" -Value
"$($gitBaseFolder)\nvim\ftdetect"
Copy-Item "$gitBaseFolder\nvim\autoload" "$HOME\AppData\Local\nvim\autoload"
