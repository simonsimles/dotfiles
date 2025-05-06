$basePath = Split-Path $PSScriptRoot
New-Item -ItemType SymbolicLink -Path "$HOME\AppData\Roaming\nushell\config.nu" -Value "$($basePath)\nushell\config.nu"
New-Item -ItemType SymbolicLink -Path "$HOME\AppData\Roaming\nushell\FuzzyCd.nu" -Value "$($basePath)\nushell\FuzzyCd.nu"
New-Item -ItemType SymbolicLink -Path "$HOME\AppData\Roaming\nushell\zoxide.nu" -Value
"$($basePath)\nushell\zoxide.nu"
