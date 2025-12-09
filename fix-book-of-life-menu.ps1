# PowerShell script to fix Book of Life menu items across all HTML files
$rootPath = "c:\xampp\htdocs\spconline"
Set-Location $rootPath

Write-Host "Fixing Book of Life menu items..." -ForegroundColor Green
Write-Host ""

# Correct Book of Life menu content
$correctBookOfLifeMenu = @"
             <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="prayer.html" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">THE BOOK OF LIFE</a>

              <div class="dropdown-menu" aria-labelledby="navbarDropdown">
              <font size="2">
                <a class="dropdown-item" href="BLwhoarewe.html">Who Are WE</a>
                <a class="dropdown-item" href="BLnatureandmission.html">Nature & Mission</a>
                <a class="dropdown-item" href="BLlifeofconsecration.html">Life of Consecration</a>
              </div></font>
"@

$htmlFiles = Get-ChildItem -Path $rootPath -Filter "*.html" | Where-Object { 
    $_.Name -ne "icon-generator.html" -and $_.Name -ne "footer.html"
}

$fixedCount = 0
$errorCount = 0

foreach ($file in $htmlFiles) {
    try {
        $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8
        $originalContent = $content
        
        # Pattern to match the broken Book of Life menu section
        $pattern = '(?s)(\s*<li class="nav-item dropdown">\s*<a class="nav-link dropdown-toggle"[^>]*>(?:\s*THE BOOK OF LIFE|\s*Book of Life)[^<]*</a>\s*<div class="dropdown-menu"[^>]*>\s*(?:<font[^>]*>)?\s*(?:<a class="dropdown-item" href="#">?</a>\s*){0,10}\s*(?:</font>)?)'
        
        if ($content -match $pattern) {
            # Replace the broken menu with the correct one
            $content = $content -replace $pattern, $correctBookOfLifeMenu
            
            # Save the file if changes were made
            if ($content -ne $originalContent) {
                $content | Set-Content -Path $file.FullName -Encoding UTF8 -NoNewline
                Write-Host "Fixed: $($file.Name)" -ForegroundColor Green
                $fixedCount++
            }
        }
    }
    catch {
        Write-Host "Error processing $($file.Name): $_" -ForegroundColor Red
        $errorCount++
    }
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Book of Life Menu Fix Complete!" -ForegroundColor Green
Write-Host "Files fixed: $fixedCount" -ForegroundColor Green
Write-Host "Errors: $errorCount" -ForegroundColor $(if ($errorCount -gt 0) { "Red" } else { "Green" })
Write-Host "========================================" -ForegroundColor Cyan
