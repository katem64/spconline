# Fix Missing </head> Tags After navbar-loader.js
# This script adds the missing </head> closing tag where needed

$files = Get-ChildItem -Filter "*.html" | Where-Object { 
    $_.Name -ne "icon-generator.html" -and 
    $_.Name -ne "footer.html" -and 
    $_.Name -ne "navbar.html" 
}

$fixedCount = 0
$alreadyOkCount = 0
$errorCount = 0

foreach ($file in $files) {
    try {
        $content = Get-Content $file.FullName -Raw
        
        # Check if file has navbar-loader but is missing </head> tag after it
        # Pattern: navbar-loader.js"></script> followed by <body (with possible blank lines)
        $pattern = 'navbar-loader\.js"></script>\s*\n\s*\n\s*<body'
        
        if ($content -match $pattern) {
            Write-Host "Fixing: $($file.Name)" -ForegroundColor Yellow
            
            # Add </head> tag between the navbar-loader script and <body>
            $replacePattern = '(navbar-loader\.js"></script>)(\s*\n)(\s*\n\s*<body)'
            $replacement = '$1' + "`r`n</head>`r`n" + '$3'
            $content = $content -replace $replacePattern, $replacement
            
            Set-Content -Path $file.FullName -Value $content -NoNewline
            $fixedCount++
        }
        # Check if it already has </head> after navbar-loader
        elseif ($content -match 'navbar-loader\.js.*</head>') {
            $alreadyOkCount++
        }
    }
    catch {
        Write-Host "Error processing $($file.Name): $_" -ForegroundColor Red
        $errorCount++
    }
}

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "SUMMARY" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Fixed: $fixedCount files" -ForegroundColor Green
Write-Host "Already OK: $alreadyOkCount files" -ForegroundColor Green
Write-Host "Errors: $errorCount files" -ForegroundColor $(if ($errorCount -gt 0) { "Red" } else { "Green" })
Write-Host "========================================" -ForegroundColor Cyan
