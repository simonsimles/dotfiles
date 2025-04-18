New-Item -ItemType SymbolicLink -Path "$HOME\.wezterm.lua" -Value (Join-Path (Split-Path $PSScriptRoot) "/wezterm/wezterm.lua")
