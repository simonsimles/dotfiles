Set-Alias -Name nvim -Value C:\tools\neovim\Neovim\bin\nvim.exe
Set-Alias -Name vim -Value nvim
function Start-Mutt {
    wsl "neomutt"
}
Set-Alias -Name mutt -Value Start-Mutt

Import-Module posh-git

Set-Alias -Name fcd -Value Invoke-FuzzySetLocation

Import-Module ~\Documents\github\cdf.ps\Cdf.psm1
Set-Alias -Name cdf -Value Set-FuzzyDirectory

Import-Module PSReadLine
Set-PSReadLineOption -EditMode Vi
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
