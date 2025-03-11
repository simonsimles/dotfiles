function Show-PDF(
    [parameter(Mandatory=$true, ValueFromPipeline=$true)] [string] $file
) {
    $fullName = Get-Item $file | Select-Object -ExpandProperty FullName
    [System.UriBuilder] $UriBuilder = [System.UriBuilder]::new("file", "")
    $UriBuilder.Path = $fullName
    Start-Process chrome $UriBuilder.Uri.AbsoluteUri
}

function Show-Tail(
    [parameter(Mandatory=$true, ValueFromPipeline=$true)] [string] $file,
    [parameter(Mandatory=$false)] [int] $n,
    [parameter(Mandatory=$false)] [switch] $f = $false
) {
    $wait = if ($f) {"-Wait"} else {""}
    $amount = if ($n) {"$n"} else {"10"}
    Invoke-Expression "Get-Content -Tail $amount $wait $file"
}

function Add-ToClip {
    [CmdletBinding()]
    param(
        [Parameter(
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true,
            Position = 0
        )] $input
    )

    Begin {
        Set-Clipboard -Value $null
    }

    Process {
        if ($_.GetType() -eq [System.IO.FileInfo]) {
            Invoke-WinCommand {param($arg) Get-Item $arg | Set-Clipboard } $_
        } else {
            Set-Clipboard -Append $_
        }
    }
}
