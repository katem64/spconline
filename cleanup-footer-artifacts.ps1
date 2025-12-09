# PowerShell script to clean up leftover HR tags and footer comments
$rootPath = "c:\xampp\htdocs\spconline"
Set-Location $rootPath

Write-Host "Cleaning up leftover footer artifacts..." -ForegroundColor Green
Write-Host ""

$htmlFiles = Get-ChildItem -Path $rootPath -Filter "*.html" | Where-Object { 
    $_.Name -ne "icon-generator.html" -and $_.Name -ne "footer.html"
}

$successCount = 0

foreach ($file in $htmlFiles) {
    try {
        $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8
        $modified = $false
        
        # Remove <hr> followed by <!-- Footer --> comment
        if ($content -match '<hr>\s*<!-- Footer -->') {
            $content = $content -replace '<hr>\s*<!-- Footer -->\s*', ''
            $modified = $true
        }
        
        # Remove standalone <!-- Footer --> comments
        if ($content -match '<!-- Footer -->\s*(?=<!-- Bootstrap)') {
            $content = $content -replace '<!-- Footer -->\s*(?=<!-- Bootstrap)', ''
            $modified = $true
        }
        
        # Remove any remaining empty <hr> before scripts
        if ($content -match '<hr>\s*(?=<!-- Bootstrap core JavaScript)') {
            $content = $content -replace '<hr>\s*(?=<!-- Bootstrap core JavaScript)', ''
            $modified = $true
        }
        
        if ($modified) {
            $content | Set-Content -Path $file.FullName -Encoding UTF8 -NoNewline
            Write-Host "Cleaned: $($file.Name)" -ForegroundColor Green
            $successCount++
        }
    }
    catch {
        Write-Host "Error processing $($file.Name): $_" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Cleanup Complete!" -ForegroundColor Green
Write-Host "Successfully cleaned: $successCount files" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
