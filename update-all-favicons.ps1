# Update all HTML files to use landing_img.png as favicon
# For SPC Online - Sisters of St. Paul of Chartres

$htmlFiles = Get-ChildItem -Path "C:\xampp\htdocs\spconline" -Filter "*.html" -File | 
    Where-Object { $_.Name -notlike "test-*" -and $_.Name -notlike "icon-generator.html" -and $_.Name -notlike "generate-favicon.html" }

$updated = 0
$skipped = 0

foreach ($file in $htmlFiles) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    $modified = $false
    
    # Replace old apple-touch-icon references
    if ($content -match 'link rel="apple-touch-icon" href="img/icon-192x192\.png"') {
        $content = $content -replace 'link rel="apple-touch-icon" href="img/icon-192x192\.png"', 'link rel="icon" type="image/png" sizes="32x32" href="img/landing_img.png?v=2">' + "`n  " + '<link rel="apple-touch-icon" href="img/landing_img.png?v=2"'
        $modified = $true
    }
    
    # Replace old icon references
    if ($content -match 'link rel="icon".*?href="icons/') {
        $content = $content -replace 'link rel="icon".*?href="icons/[^"]*"', 'link rel="icon" type="image/png" sizes="32x32" href="img/landing_img.png?v=2"'
        $modified = $true
    }
    
    if ($modified) {
        Set-Content -Path $file.FullName -Value $content -Encoding UTF8 -NoNewline
        Write-Host "✓ Updated: $($file.Name)" -ForegroundColor Green
        $updated++
    } else {
        Write-Host "- Skipped: $($file.Name) (already up-to-date or no icon reference)" -ForegroundColor Gray
        $skipped++
    }
}

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "Favicon Update Complete!" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Updated: $updated files" -ForegroundColor Green
Write-Host "Skipped: $skipped files" -ForegroundColor Yellow
Write-Host "`nAll pages now use landing_img.png as favicon!" -ForegroundColor Green
