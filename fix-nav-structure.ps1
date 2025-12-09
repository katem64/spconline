# Fix Navigation HTML Structure
# Add missing closing </li> tags after dropdown menus

$files = Get-ChildItem -Filter "*.html" | Where-Object { 
    $_.Name -ne "icon-generator.html" -and $_.Name -ne "footer.html" 
}

$fixed = 0
$errors = 0

foreach ($file in $files) {
    try {
        $content = Get-Content $file.FullName -Raw -Encoding UTF8
        $originalContent = $content
        
        # Fix 1: Add </li> after Basic Prayers dropdown
        $content = $content -replace '(afterconfession\.html">Prayer after Confession</a>\s*</div>)\s*(<li class="nav-item dropdown">)', '$1</li>$2'
        
        # Fix 2: Add </li> after The Rosary dropdown
        $content = $content -replace '(glorious\.html">The Mysteries of Glory</a>\s*</div>)\s*(<li class="nav-item dropdown">)', '$1</li>$2'
        
        # Fix 3: Add </li> after Formulary Prayers dropdown
        $content = $content -replace '(TheChapletofDivineMercy\.html">The Chaplet of Divine Mercy</a>\s*</div>)\s*(<li class="nav-item dropdown">)', '$1</li>$2'
        
        # Fix 4: Close Book of Life properly - fix the closing tags
        $content = $content -replace '</div></font></div>', '</font></div></li>'
        
        if ($content -ne $originalContent) {
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
Write-Host "Navigation HTML Structure Fix Complete" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Files fixed: $fixed" -ForegroundColor Green
Write-Host "Errors: $errors" -ForegroundColor $(if ($errors -eq 0) { "Green" } else { "Red" })
