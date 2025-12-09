# PowerShell script to update all prayer pages with PWA features
# This updates the remaining HTML files (excluding index.html and joy.html which are already updated)

$rootPath = "c:\xampp\htdocs\spconline"
Set-Location $rootPath

# Get all HTML files except index.html and joy.html
$htmlFiles = Get-ChildItem -Path $rootPath -Filter "*.html" | Where-Object { 
    $_.Name -ne "index.html" -and $_.Name -ne "joy.html" 
}

Write-Host "Found $($htmlFiles.Count) HTML files to update" -ForegroundColor Green
Write-Host ""

$successCount = 0
$errorCount = 0

foreach ($file in $htmlFiles) {
    Write-Host "Processing: $($file.Name)..." -ForegroundColor Yellow
    
    try {
        # Read the file content
        $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8
        
        # Check if already updated (contains theme.css)
        if ($content -match 'css/theme\.css') {
            Write-Host "  - Already updated, skipping" -ForegroundColor Cyan
            continue
        }
        
        # 1. Add PWA meta tags and CSS links after <title>
        $pwaMeta = @"
  <title>SPC Online</title>

  <!-- PWA Meta Tags -->
  <meta name="theme-color" content="#3498DB">
  <meta name="apple-mobile-web-app-capable" content="yes">
  <meta name="apple-mobile-web-app-status-bar-style" content="default">
  <meta name="apple-mobile-web-app-title" content="SPC Online">
  <link rel="manifest" href="manifest.json">
  <link rel="apple-touch-icon" href="img/icon-192x192.png">

  <!-- Bootstrap core CSS -->
"@
        $content = $content -replace '  <title>SPC Online</title>\s+<!-- Bootstrap core CSS -->', $pwaMeta
        
        # 2. Add PWA CSS after clean-blog.min.css
        $pwaCss = @"
  <link href="css/clean-blog.min.css" rel="stylesheet">
  
  <!-- PWA Styles -->
  <link href="css/theme.css" rel="stylesheet">
  <link href="css/dark-mode.css" rel="stylesheet">
"@
        $content = $content -replace '  <link href="css/clean-blog\.min\.css" rel="stylesheet">', $pwaCss
        
        # 3. Remove lightyellow background
        $content = $content -replace '<body\s+style="background-color:\s*lightyellow">', '<body>'
        
        # 4. Add PWA controls after </header>
        $pwaControls = @"
  </header>

  <!-- PWA Controls -->
  <div class="pwa-controls"></div>

  <!-- Main Content -->
"@
        $content = $content -replace '  </header>\s+<!-- Main Content -->', $pwaControls
        
        # 5. Add PWA scripts before </body>
        $pwaScripts = @"
  <!-- Custom scripts for this template -->
  <script src="js/clean-blog.min.js"></script>

  <!-- PWA Scripts -->
  <script src="js/app.js"></script>
  <script src="js/font-size.js"></script>
  <script src="js/bookmarks.js"></script>
  <script src="js/search.js"></script>

</body>
"@
        $content = $content -replace '  <!-- Custom scripts for this template -->\s+<script src="js/clean-blog\.min\.js"></script>\s+</body>', $pwaScripts
        
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
Write-Host "Update Complete!" -ForegroundColor Green
Write-Host "Successfully updated: $successCount files" -ForegroundColor Green
Write-Host "Errors: $errorCount files" -ForegroundColor $(if ($errorCount -gt 0) { "Red" } else { "Green" })
Write-Host "========================================" -ForegroundColor Cyan
