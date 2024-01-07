Import-Module (Join-Path $PSScriptRoot "Menu.psm1")

function Set-GitBranch {
    [CmdletBinding()]

    $branches =  & "git" "branch" "--no-color" | ForEach-Object { $_ -replace "^(\*)?\s+", "" }

    $additionalKeyActions = @{
        [System.ConsoleKey]::D = {$args[0], "D"}
        [System.ConsoleKey]::C = {$null, "C"}
    }
    $legend = "[Enter] switch to branch, [Escape] abort, [d] delete, [c] create new branch"
    $prompt = "Select Git branch"
    $branch, $operation = Get-Choice $branches -legend $legend -prompt $prompt -additionalKeyActions $additionalKeyActions
    if ($operation -eq "D") {
        Write-Host "Delete $branch"
        & "git" "branch" "--delete" $branch
        Set-GitBranch
    } elseif ($operation -eq "C") {
        $newBranch = Read-Host "Enter new branch name"
        & "git" "checkout" "-b" $newBranch
    } elseif ($branch) {
        Write-Host "Change to $branch"
        & "git" "checkout" $branch
    }
}
