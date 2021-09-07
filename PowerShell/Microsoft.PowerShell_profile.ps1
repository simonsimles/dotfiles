Set-Alias -Name nvim -Value C:\tools\neovim\Neovim\bin\nvim.exe
function Start-Mutt {
    wsl "neomutt"
}
Set-Alias -Name mutt -Value Start-Mutt

Import-Module posh-git

Set-Alias -Name fcd -Value Invoke-FuzzySetLocation
