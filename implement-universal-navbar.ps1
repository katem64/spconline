# Replace All Navbars with Universal Navbar Loader
# This script removes hardcoded navbars and adds the navbar-loader.js

$files = Get-ChildItem -Filter "*.html" | Where-Object { 
    $_.Name -ne "icon-generator.html" -and $_.Name -ne "footer.html" -and $_.Name -ne "navbar.html"
}

$fixed = 0
$errors = 0
$skipped = 0

foreach ($file in $files) {
    try {
        $content = Get-Content $file.FullName -Raw -Encoding UTF8
        $originalContent = $content
        
        # Check if navbar-loader.js already exists
        if ($content -match 'navbar-loader\.js') {
            Write-Host "Skipped: $($file.Name) - already has navbar-loader" -ForegroundColor Yellow
            $skipped++
            continue
        }
        
        # Pattern 1: Remove navbar from <body> to </nav>
        # This matches from <body> tag through the entire navbar structure ending with </nav>
        $navbarPattern = '(?s)(<body[^>]*>)\s*(?:<!--[^>]*?>)?\s*<!--\s*Navigation\s*-->\s*<nav\s+class="navbar[^"]*"[^>]*>.*?</nav>'
        
        if ($content -match $navbarPattern) {
            # Replace navbar with just the body tag and navbar loader script reference
            $content = $content -replace $navbarPattern, '$1'
            
            # Add navbar-loader.js script before closing </head> tag
            if ($content -notmatch 'navbar-loader\.js') {
                $content = $content -replace '(\s*</head>)', "`r`n  <!-- Universal Navbar Loader -->`r`n  <script src=`"js/navbar-loader.js`"></script>$1"
            }
            
            Set-Content -Path $file.FullName -Value $content -Encoding UTF8 -NoNewline
            Write-Host "Fixed: $($file.Name)" -ForegroundColor Green
            $fixed++
        } else {
            Write-Host "Warning: $($file.Name) - navbar pattern not found" -ForegroundColor Yellow
            $skipped++
        }
    }
    catch {
        Write-Host "Error processing $($file.Name): $_" -ForegroundColor Red
        $errors++
    }
}

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "Universal Navbar Implementation Complete" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Files fixed: $fixed" -ForegroundColor Green
Write-Host "Files skipped: $skipped" -ForegroundColor Yellow
Write-Host "Errors: $errors" -ForegroundColor $(if ($errors -eq 0) { "Green" } else { "Red" })
Write-Host "`nAll pages now use: navbar.html + navbar-loader.js" -ForegroundColor Cyan
