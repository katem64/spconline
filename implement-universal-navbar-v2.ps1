# Replace All Navbars with Universal Navbar Loader - Version 2
# More flexible pattern matching for different navbar formats

$files = Get-ChildItem -Filter "*.html" | Where-Object { 
    $_.Name -ne "icon-generator.html" -and $_.Name -ne "footer.html" -and $_.Name -ne "navbar.html"
}

$fixed = 0
$errors = 0
$alreadyHas = 0

foreach ($file in $files) {
    try {
        $content = Get-Content $file.FullName -Raw -Encoding UTF8
        $originalContent = $content
        
        # Check if navbar-loader.js already exists
        if ($content -match 'navbar-loader\.js') {
            $alreadyHas++
            continue
        }
        
        # Pattern: Match from <body> tag to </nav> (more flexible)
        # Handles different formats: with/without comments, different spacing, etc.
        $navbarPattern = '(?s)(<body[^>]*>)\s*(?:<!--[^>]*?-->)?\s*(?:<!--\s*Navigation\s*-->\s*)?<nav\s+class="navbar[^"]*"[^>]*>.*?</nav>\s*'
        
        if ($content -match $navbarPattern) {
            # Replace navbar with just the body tag
            $replacement = '$1' + "`r`n"
            $content = $content -replace $navbarPattern, $replacement
            
            # Add navbar-loader.js script before closing </head> tag
            $headReplacement = "`r`n  <!-- Universal Navbar Loader -->`r`n  <script src=`"js/navbar-loader.js`"></script>`r`n</head>"
            $content = $content -replace '</head>', $headReplacement
            
            Set-Content -Path $file.FullName -Value $content -Encoding UTF8 -NoNewline
            Write-Host "Fixed: $($file.Name)" -ForegroundColor Green
            $fixed++
        } else {
            Write-Host "No navbar found: $($file.Name)" -ForegroundColor DarkGray
        }
    }
    catch {
        Write-Host "Error processing $($file.Name): $_" -ForegroundColor Red
        $errors++
    }
}

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "Universal Navbar Implementation - Round 2" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Files fixed: $fixed" -ForegroundColor Green
Write-Host "Already had navbar-loader: $alreadyHas" -ForegroundColor Cyan
Write-Host "Errors: $errors" -ForegroundColor $(if ($errors -eq 0) { "Green" } else { "Red" })
