Set-Alias -Name nvim -Value C:\tools\neovim\nvim-win64\bin\nvim.exe
Set-Alias -Name vim -Value nvim
function Start-Mutt {
    wsl "neomutt"
}
Set-Alias -Name mutt -Value Start-Mutt

Import-Module posh-git

function Set-FzfLocation {
    rg --files -g "!GrueneWolke/" | fzf | Split-Path | Set-Location
}
Set-Alias -Name fcd -Value Set-FzfLocation

function Get-FZFFile {
    rg --files -g "!GrueneWolke/" | fzf
}
Set-Alias -Name ff -Value Get-FZFFile

Import-Module ~\Documents\github\cdf.ps\Cdf.psm1
if (Get-Module Cdf) {
    Set-CdAlias
}

Import-Module PSReadLine
#Set-PSReadLineOption -EditMode Vi
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
Set-PSReadLineOption -Color @{"Parameter" = "Magenta"; "Operator" = "Magenta"}

$module_path = Get-Item $profile | Select-Object -ExpandProperty Target | foreach {
    if ($_) {Split-Path $_} else {$PSScriptRoot}
}
Import-Module (Join-Path $module_path "helpers.psm1")
Set-Alias pdfv -Value Show-PDF
Set-Alias tail -Value Show-Tail
