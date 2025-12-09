# Simple script to add defer to all navbar-loader.js scripts
Get-ChildItem *.html | ForEach-Object {
    $content = Get-Content $_.FullName -Raw
    if ($content -match '<script src="js/navbar-loader\.js"></script>') {
        $content = $content.Replace('<script src="js/navbar-loader.js"></script>', '<script defer src="js/navbar-loader.js"></script>')
        [System.IO.File]::WriteAllText($_.FullName, $content)
        Write-Host "Updated: $($_.Name)"
    }
}
Write-Host "`nDone!" -ForegroundColor Green
