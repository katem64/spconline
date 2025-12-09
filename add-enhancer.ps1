# Add prayer-enhancer.js to all prayer pages
$files = Get-ChildItem -Path "c:\xampp\htdocs\spconline\" -Filter "*.html" | 
    Where-Object { 
        $_.Name -ne "index.html" -and 
        $_.Name -ne "landing.html" -and 
        $_.Name -ne "navbar.html" -and 
        $_.Name -ne "footer.html" -and
        $_.Name -notlike "test-*" -and
        $_.Name -ne "icon-generator.html"
    }

$count = 0
foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    
    # Check if prayer-enhancer.js is already added
    if ($content -notmatch 'prayer-enhancer\.js') {
        # Add before </body> tag
        $content = $content -replace '(</body>)', "  <script src=`"js/prayer-enhancer.js`"></script>`n`$1"
        $content | Set-Content $file.FullName -Encoding UTF8 -NoNewline
        $count++
        Write-Host "Added to $($file.Name)"
    }
}

Write-Host "`nCompleted! Added prayer-enhancer.js to $count files."
