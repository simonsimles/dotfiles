Set-Alias -Name vim -Value nvim

function Restart-PowerToys {
     Get-Process | Where-Object {$_.Name -eq "PowerToys"} | Select-Object -first 1 | Stop-Process
     & 'C:\Program Files\PowerToys\PowerToys.exe'
}

# posh-git: defer loading until we detect a git repository to speed startup
$global:__poshgit_initialized = $false

function Set-FzfLocation {
    rg --files -g "!GrueneWolke/" | fzf | Split-Path | Set-Location
}
Set-Alias -Name fcd -Value Set-FzfLocation

function Get-FZFFile {
    rg --files -g "!GrueneWolke/" | fzf
}
Set-Alias -Name ff -Value Get-FZFFile

# Only import the local Cdf module if it exists to avoid costly module resolution
$cdfPath = Join-Path $HOME 'Documents\github\cdf.ps\Cdf.psm1'
if (Test-Path $cdfPath) { Import-Module $cdfPath }
#if (Get-Module Cdf) {
    # Set-CdAlias
#}

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
Set-PSReadLineOption -Color @{"Parameter" = "Magenta"; "Operator" = "Magenta"}

#$module_path = Get-Item $profile | Select-Object -ExpandProperty Target | foreach {
#    if ($_) {Split-Path $_} else {$PSScriptRoot}
#}
#Import-Module (Join-Path $module_path "helpers.psm1")
#Set-Alias pdfv -Value Show-PDF
#Set-Alias tail -Value Show-Tail
#. (Join-Path $module_path "git_helpers.ps1")
#. (Join-Path $module_path "preview.ps1")

$env:YAZI_FILE_ONE="C:\Users\d91069\scoop\apps\git\current\usr\bin\file.exe"
function y {
    $tmp = [System.IO.Path]::GetTempFileName()
    yazi $args --cwd-file="$tmp"
    $cwd = Get-Content -Path $tmp
    if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
        Set-Location -LiteralPath $cwd
    }
    Remove-Item -Path $tmp
}

# Defer starship and zoxide initialization until the first prompt to speed up
# profile sourcing. On first prompt call we'll initialize them and then call
# the (possibly newly-defined) prompt function.
$global:__starship_initialized = $false
$global:__zoxide_initialized = $false

function global:prompt {
    if (-not $global:__starship_initialized) {
        if (Get-Command starship -ErrorAction SilentlyContinue) {
            try { Invoke-Expression (&starship init powershell) } catch { }
        }
        $global:__starship_initialized = $true
        # If starship replaced the prompt function, call it now.
        if ((Get-Command prompt -ErrorAction SilentlyContinue).CommandType -eq 'Function') {
            return & prompt
        }
    }

    if (-not $global:__zoxide_initialized) {
        if (Get-Command zoxide -ErrorAction SilentlyContinue) {
            try { Invoke-Expression (& { (zoxide init powershell | Out-String) }) } catch { }
        }
        $global:__zoxide_initialized = $true
    }

    # Initialize posh-git lazily: if we're in a git repo and posh-git isn't loaded,
    # import it. This avoids the import cost at every shell startup.
    if (-not $global:__poshgit_initialized) {
        try {
            git rev-parse --is-inside-work-tree > $null 2>&1
            $isGitRepo = $LASTEXITCODE -eq 0
        } catch {
            $isGitRepo = $false
        }
        if ($isGitRepo -and (Get-Module -ListAvailable -Name posh-git)) {
            try { Import-Module posh-git -ErrorAction SilentlyContinue } catch { }
        }
        $global:__poshgit_initialized = $true
    }

    # Fallback simple prompt until a richer prompt is available.
    return "PS $($executionContext.SessionState.Path.CurrentLocation)> "
}
