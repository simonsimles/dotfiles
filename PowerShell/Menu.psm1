function Write-ItemLines([array] $items, [int] $selectedIndex) {
    0..($items.Count -1) | ForEach-Object {
        Write-Host -NoNewline " "
        if ($_ -eq $selectedIndex) {
            Write-Host -NoNewline -BackgroundColor Magenta -ForegroundColor White "$($items[$_])"
        } else {
            Write-Host -NoNewline "$($items[$_])"
        }
        Write-Host " "
    }
}

function Write-PromptOrFooter($message) {
    if ([String]::IsNullOrEmpty($message)) {return}
    Write-Host -ForegroundColor Cyan $message
}

function Clear-LinesAbove([int] $numberOfLinesToClear) {
    [System.Console]::SetCursorPosition(0, [System.Console]::CursorTop - $numberOfLinesToClear)
    1..$numberOfLinesToClear | ForEach-Object {
        Write-Host "".PadRight([System.Console]::BufferWidth, " ")
    }
    [System.Console]::SetCursorPosition(0, [System.Console]::CursorTop - $numberOfLinesToClear)
}

function Get-ConsolePrintHeightForString([string] $stringToPrint) {
    if (-not $stringToPrint) {0}
    else {
        ($stringToPrint -split "`n") | ForEach-Object {
             [math]::floor($_.Length / ([System.Console]::BufferWidth +1)) + 1
        } | Measure-Object -Sum | Select-Object -ExpandProperty Sum
    }
}

function Get-Choice(
    [Parameter(Mandatory=$true)] [string[]] $items,
    [Parameter(Mandatory = $false)] [string] $prompt,
    [Parameter(Mandatory = $false)] [string] $legend,
    [Parameter(Mandatory = $false)] [hashtable] $additionalKeyActions
){
    $choice = 0
    $pageHeight = [System.Console]::BufferHeight, 10 | Measure-Object -Minimum | Select-Object -ExpandProperty Minimum
    $maxPage = [Math]::Ceiling($items.Length / $pageHeight)-1
    $currentPage = 0
    $legendOffset = Get-ConsolePrintHeightForString $legend
    $promptOffset = Get-ConsolePrintHeightForString $prompt
    try {
        [System.Console]::CursorVisible = $false
        Write-PromptOrFooter $prompt
        $currentPageItems = $items[($currentPage * $pageHeight)..(($currentPage + 1) * $pageHeight - 1)]
        Write-ItemLines $currentPageItems $choice
        Write-Host -ForegroundColor ([System.ConsoleColor]::DarkYellow) "Page $($currentPage + 1)/$($maxPage + 1)"
        Write-PromptOrFooter $legend

        while($true) {
            $press = [System.Console]::ReadKey($true)
            if ($press.Key -eq [System.ConsoleKey]::UpArrow -or $press.Key -eq [System.ConsoleKey]::K) {
                $choice = ($choice - 1), 0 | Measure-Object -Maximum | Select-Object -ExpandProperty Maximum
            } elseif ($press.Key -eq [System.ConsoleKey]::DownArrow -or $press.Key -eq [System.ConsoleKey]::J) {
                $choice = ($choice + 1), ($items.Count - 1) | Measure-Object -Minimum | Select-Object -ExpandProperty Minimum
            } elseif ($press.Key -eq [System.ConsoleKey]::RightArrow -or $press.Key -eq [System.ConsoleKey]::L) {
                $currentPage = ($currentPage + 1), $maxPage | Measure-Object -Minimum | Select-Object -ExpandProperty Minimum
                $choice = 0
            } elseif ($press.Key -eq [System.ConsoleKey]::LeftArrow -or $press.Key -eq [System.ConsoleKey]::H) {
                $currentPage = ($currentPage - 1), 0 | Measure-Object -Maximum | Select-Object -ExpandProperty Maximum
                $choice = 0
            }

            if ($press.Key -eq [System.ConsoleKey]::Escape) {
                return $null
            } elseif ($press.Key -eq [System.ConsoleKey]::Enter) {
                return $currentPageItems[$choice]
            }
            if ($additionalKeyActions -and $additionalKeyActions.ContainsKey($press.Key)) {
                return & $additionalKeyActions[$press.Key] $currentPageItems[$choice]
            }

            Clear-LinesAbove ($currentPageItems.Length + 1 + $legendOffset)
            $currentPageItems = $items[($currentPage * $pageHeight)..(($currentPage + 1) * $pageHeight - 1)]
            Write-ItemLines $currentPageItems $choice
            Write-Host -ForegroundColor ([System.ConsoleColor]::DarkYellow) "Page $($currentPage + 1)/$($maxPage + 1)"
            Write-PromptOrFooter $legend
        }
    } finally {
        Clear-LinesAbove ($currentPageItems.Length + 1 + $promptOffset + $legendOffset)
        [System.Console]::CursorVisible = $true
    }
}

Export-ModuleMember -Function @(
    "Get-Choice"
)
