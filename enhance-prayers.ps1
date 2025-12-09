# Add modern styling to all prayer pages
# This adds modern-theme.css and prayer-enhancer.js to all HTML files

$files = Get-ChildItem -Path "c:\xampp\htdocs\spconline\" -Filter "*.html" | 
    Where-Object { 
        $_.Name -ne "index.html" -and 
        $_.Name -ne "landing.html" -and 
        $_.Name -ne "navbar.html" -and 
        $_.Name -ne "footer.html" -and
        $_.Name -notlike "test-*"
    }

Write-Host "Found $($files.Count) prayer pages to enhance"

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    
    # Check if modern-theme.css is already added
    if ($content -notmatch 'modern-theme\.css') {
        # Add modern-theme.css after dark-mode.css
        $content = $content -replace '(<link href="css/dark-mode\.css" rel="stylesheet">)', "`$1`n  <link href=`"css/modern-theme.css`" rel=`"stylesheet`">"
        
        Write-Host "✓ Added modern-theme.css to $($file.Name)"
    }
    
    # Check if prayer-enhancer.js is already added
    if ($content -notmatch 'prayer-enhancer\.js') {
        # Add prayer-enhancer.js before the closing </body> tag
        $content = $content -replace '(</body>)', "  <script src=`"js/prayer-enhancer.js`"></script>`n`$1"
        
        Write-Host "✓ Added prayer-enhancer.js to $($file.Name)"
    }
    
    # Save the file
    $content | Set-Content $file.FullName -Encoding UTF8 -NoNewline
}

Write-Host "`nEnhancement complete! $($files.Count) files updated."
