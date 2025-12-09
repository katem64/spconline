# Fix Book of Life Navigation Chaos
# Remove duplicate menu items that appear outside the dropdown div

$files = Get-ChildItem -Filter "*.html" | Where-Object { 
    $_.Name -ne "icon-generator.html" -and $_.Name -ne "footer.html" 
}

$fixed = 0
$errors = 0

# The broken pattern: duplicate menu items outside the dropdown
$brokenPattern = '              </div></font><a class="dropdown-item" href="BLwhoarewe.html">Who Are WE</a>
                <a class="dropdown-item" href="BLnatureandmission.html">Nature & Mission</a>
                <a class="dropdown-item" href="BLlifeofconsecration.html">Life of Consecration</a>
              </div></font>'

# The correct pattern: proper closing tags
$correctPattern = '              </font></div>'

foreach ($file in $files) {
    try {
        $content = Get-Content $file.FullName -Raw -Encoding UTF8
        
        if ($content -match [regex]::Escape($brokenPattern)) {
            $content = $content -replace [regex]::Escape($brokenPattern), $correctPattern
            Set-Content -Path $file.FullName -Value $content -Encoding UTF8 -NoNewline
            Write-Host "Fixed: $($file.Name)" -ForegroundColor Green
            $fixed++
        }
    }
    catch {
        Write-Host "Error processing $($file.Name): $_" -ForegroundColor Red
        $errors++
    }
}

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "Book of Life Navigation Fix Complete" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Files fixed: $fixed" -ForegroundColor Green
Write-Host "Errors: $errors" -ForegroundColor $(if ($errors -eq 0) { "Green" } else { "Red" })
