# Add defer attribute to navbar-loader.js script tags
$files = Get-ChildItem -Filter "*.html" | Where-Object { 
    $_.Name -ne "icon-generator.html" -and 
    $_.Name -ne "footer.html" -and 
    $_.Name -ne "navbar.html" 
}

$fixedCount = 0

foreach ($file in $files) {
    try {
        $content = Get-Content $file.FullName -Raw
        
        # Check if file has navbar-loader without defer
        if ($content -match '<script src="js/navbar-loader\.js"></script>' -and 
            $content -notmatch '<script defer src="js/navbar-loader\.js"></script>') {
            
            Write-Host "Fixing: $($file.Name)" -ForegroundColor Yellow
            
            # Add defer attribute
            $content = $content -replace '<script src="js/navbar-loader\.js"></script>', '<script defer src="js/navbar-loader.js"></script>'
            
            Set-Content -Path $file.FullName -Value $content -NoNewline
            $fixedCount++
        }
    }
    catch {
        Write-Host "Error processing $($file.Name): $_" -ForegroundColor Red
    }
}

Write-Host "`nFixed $fixedCount files with defer attribute" -ForegroundColor Green
