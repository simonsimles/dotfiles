New-Item -ItemType SymbolicLink -Path "$HOME\AppData\Roaming\yazi\config\yazi.toml" -Value (Join-Path (Split-Path $PSScriptRoot) "/yazi\yazi.toml")
