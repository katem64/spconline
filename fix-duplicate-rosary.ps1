# Fix Duplicate Rosary Menu Items in Navigation
# Remove the second duplicate "The Rosary" dropdown

$files = Get-ChildItem -Filter "*.html" | Where-Object { 
    $_.Name -ne "icon-generator.html" -and $_.Name -ne "footer.html" 
}

$fixed = 0
$errors = 0

# Pattern to find and remove the duplicate Rosary menu
$duplicatePattern = @'
              
               <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="prayer.html" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
              The Rosary
            </a>
               <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                <a class="dropdown-item" href="joy.html">The Mysteries of Joy</a>
                <a class="dropdown-item" href="light.html">The Mysteries of Light</a>
                <a class="dropdown-item" href="sorrow.html">The Mysteries of Sorrow</a>
                <a class="dropdown-item" href="glorious.html">The Mysteries of Glory</a>
              </div>
'@

foreach ($file in $files) {
    try {
        $content = Get-Content $file.FullName -Raw -Encoding UTF8
        
        if ($content -match [regex]::Escape($duplicatePattern)) {
            # Remove the duplicate Rosary menu
            $content = $content -replace [regex]::Escape($duplicatePattern), ''
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
Write-Host "Duplicate Rosary Menu Fix Complete" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Files fixed: $fixed" -ForegroundColor Green
Write-Host "Errors: $errors" -ForegroundColor $(if ($errors -eq 0) { "Green" } else { "Red" })
