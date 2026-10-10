$dir = "C:\Users\keane\Downloads\SafeReturn - UI"
$files = Get-ChildItem -LiteralPath $dir -Filter "*.svg"

$colors = [System.Collections.Generic.HashSet[string]]::new()
$fonts = [System.Collections.Generic.HashSet[string]]::new()
$fontSizes = [System.Collections.Generic.HashSet[string]]::new()
$radii = [System.Collections.Generic.HashSet[string]]::new()

foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file.FullName)
    Write-Output "========================================"
    Write-Output "FILE: $($file.Name)"
    Write-Output "========================================"
    
    # Extract dimensions
    if ($content -match 'width="([0-9.]+)"\s+height="([0-9.]+)"') {
        Write-Output "Canvas: $($matches[1]) x $($matches[2])"
    }

    # Extract text contents
    $textMatches = [regex]::Matches($content, '<text[^>]*>(.*?)</text>', [System.Text.RegularExpressions.RegexOptions]::Singleline)
    $fileTexts = [System.Collections.Generic.List[string]]::new()
    foreach ($tm in $textMatches) {
        $raw = [regex]::Replace($tm.Groups[1].Value, '<[^>]+>', ' ').Trim()
        $raw = [System.Net.WebUtility]::HtmlDecode($raw)
        $raw = [regex]::Replace($raw, '\s+', ' ')
        if ($raw.Length -gt 0 -and -not $fileTexts.Contains($raw)) {
            $fileTexts.Add($raw)
        }
    }
    Write-Output "TEXT COUNT: $($fileTexts.Count)"
    Write-Output ($fileTexts -join '  ||  ')

    # Collect tokens
    foreach ($m in [regex]::Matches($content, 'fill="([#0-9a-fA-F]{4,9})"', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)) {
        [void]$colors.Add($m.Groups[1].Value.ToUpper())
    }
    foreach ($m in [regex]::Matches($content, 'stroke="([#0-9a-fA-F]{4,9})"', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)) {
        [void]$colors.Add($m.Groups[1].Value.ToUpper())
    }
    foreach ($m in [regex]::Matches($content, 'font-family="([^"]+)"', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)) {
        [void]$fonts.Add($m.Groups[1].Value)
    }
    foreach ($m in [regex]::Matches($content, 'font-size="([^"]+)"', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)) {
        [void]$fontSizes.Add($m.Groups[1].Value)
    }
    foreach ($m in [regex]::Matches($content, 'rx="([0-9.]+)"', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)) {
        [void]$radii.Add($m.Groups[1].Value)
    }
}

Write-Output "`n========================================"
Write-Output "ALL UNIQUE COLORS:"
Write-Output ($colors | Sort-Object)
Write-Output "`nALL UNIQUE FONTS:"
Write-Output ($fonts | Sort-Object)
Write-Output "`nALL UNIQUE FONT SIZES:"
Write-Output ($fontSizes | Sort-Object -Descending { [double]$_ })
Write-Output "`nALL UNIQUE RADII:"
Write-Output ($radii | Sort-Object -Descending { [double]$_ })
