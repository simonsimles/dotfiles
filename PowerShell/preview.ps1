function Start-SvgPreview {
    param (
        [string]$Path
    )

    while ($True) {
        $currDir = Get-Location
        try {
            Set-Location $Path
            $selection = (ff)
            if (-not $selection) {
                return
            }
            $candidate = Get-Item $selection | Select-Object -ExpandProperty FullName
        } finally {
            Set-Location $currDir
        }
        Start-Process "chrome" -ArgumentList @("--new-window", "--window-size=150,150", "--app=`"$candidate`"") -Wait

        $prompt = "Press Enter to accept, any key to continue"
        Write-Host $prompt
        $keyPressed = [System.Console]::ReadKey($true)
        if ($keyPressed.Key -eq [System.ConsoleKey]::Enter) {
            $candidate | Set-Clipboard
            return
        }
    }
}

function Start-AzureIcons { 
    Start-SvgPreview -Path (Join-Path (Get-Item ~ | Select-Object -ExpandProperty FullName)     "Downloads\Azure_Public_Service_Icons_V19\Azure_Public_Service_Icons\Icons")
}
