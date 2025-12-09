# PowerShell script to replace all footers with universal footer loader
$rootPath = "c:\xampp\htdocs\spconline"
Set-Location $rootPath

Write-Host "Replacing all footers with universal footer loader..." -ForegroundColor Green
Write-Host ""

$htmlFiles = Get-ChildItem -Path $rootPath -Filter "*.html" | Where-Object { 
    $_.Name -ne "icon-generator.html" -and $_.Name -ne "footer.html"
}

$successCount = 0
$errorCount = 0

foreach ($file in $htmlFiles) {
    Write-Host "Processing: $($file.Name)..." -ForegroundColor Yellow
    
    try {
        # Read the file content
        $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8
        
        # Check if footer loader already added
        if ($content -match 'footer-loader\.js') {
            Write-Host "  - Already has footer loader, skipping" -ForegroundColor Cyan
            continue
        }
        
        # Remove entire old footer section (from <footer> to </footer>)
        $content = $content -replace '(?s)<footer[^>]*>.*?</footer>', ''
        
        # Remove the <hr> before footer if exists
        $content = $content -replace '\s*<hr>\s*(?=\s*<!-- Bootstrap core JavaScript)', ''
        
        # Add footer loader script before </body>
        $footerScript = '
  <!-- Universal Footer Loader -->
  <script src="js/footer-loader.js"></script>

</body>'
        
        $content = $content -replace '</body>', $footerScript
        
        # Write back to file
        $content | Set-Content -Path $file.FullName -Encoding UTF8 -NoNewline
        
        Write-Host "  - Updated successfully!" -ForegroundColor Green
        $successCount++
    }
    catch {
        Write-Host "  - Error: $_" -ForegroundColor Red
        $errorCount++
    }
    
    Write-Host ""
}

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Footer Replacement Complete!" -ForegroundColor Green
Write-Host "Successfully updated: $successCount files" -ForegroundColor Green
Write-Host "Errors: $errorCount files" -ForegroundColor $(if ($errorCount -gt 0) { "Red" } else { "Green" })
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "All pages now use the universal teal footer from footer.html" -ForegroundColor White
