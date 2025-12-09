# Final Script: Add defer to all navbar-loader.js scripts
# This ensures navbar loads AFTER the DOM is ready

Write-Host "`nAdding defer attribute to all HTML files..." -ForegroundColor Cyan

$files = Get-ChildItem -Filter "*.html" | Where-Object {
    $_.Name -ne "icon-generator.html" -and 
    $_.Name -ne "footer.html" -and 
    $_.Name -ne "navbar.html"
}

$updated = 0

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    
    # Check if file needs updating
    if ($content -match '<script src="js/navbar-loader\.js"></script>' -and 
        $content -notmatch '<script defer src="js/navbar-loader\.js"></script>') {
        
        # Replace without defer to with defer
        $newContent = $content -replace '<script src="js/navbar-loader\.js"></script>', 
                                       '<script defer src="js/navbar-loader.js"></script>'
        
        # Write back to file
        $newContent | Set-Content -Path $file.FullName -Encoding UTF8 -NoNewline
        
        Write-Host "  ✓ $($file.Name)" -ForegroundColor Green
        $updated++
    }
}

Write-Host "`nUpdated $updated files!" -ForegroundColor Yellow
Write-Host "`nNow refresh your browser with Ctrl+Shift+R" -ForegroundColor Cyan
Write-Host "The navbar should appear on all pages!" -ForegroundColor Green
