Set-Alias -Name nvim -Value C:\tools\neovim\Neovim\bin\nvim.exe
Set-Alias -Name vim -Value nvim
function Start-Mutt {
    wsl "neomutt"
}
Set-Alias -Name mutt -Value Start-Mutt

Import-Module posh-git

Set-Alias -Name fcd -Value Invoke-FuzzySetLocation

Import-Module ~\Documents\github\cdf.ps\Cdf.psm1
if (Get-Module Cdf) {
    Remove-Alias cd
    Set-Alias -Name cd -Value Set-FuzzyDirectory
}

Import-Module PSReadLine
Set-PSReadLineOption -EditMode Vi
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

function OnViModeChange {
    if ($args[0] -eq 'Command') {
        # Set the cursor to a blinking block.
        Write-Host -NoNewLine "`e[1 q"
    } else {
        # Set the cursor to a blinking line.
        Write-Host -NoNewLine "`e[5 q"
    }
}
Set-PSReadLineOption -ViModeIndicator Script -ViModeChangeHandler $Function:OnViModeChange

Set-PSReadLineOption -BellStyle None

Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
