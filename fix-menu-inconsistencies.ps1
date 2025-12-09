# PowerShell script to fix menu inconsistencies and duplicates
$rootPath = "c:\xampp\htdocs\spconline"
Set-Location $rootPath

Write-Host "Fixing menu inconsistencies..." -ForegroundColor Green
Write-Host ""

$htmlFiles = Get-ChildItem -Path $rootPath -Filter "*.html"
$totalFixed = 0

foreach ($file in $htmlFiles) {
    $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8
    $modified = $false
    
    # Fix duplicate "light.html" in Rosary menu (should be sorrow.html)
    $rosaryPattern = '(<a class="dropdown-item" href="joy\.html">The Mysteries of Joy</a>\s+<a class="dropdown-item" href="light\.html">The Mysteries of Light</a>\s+<a class="dropdown-item" href="glorious\.html">The Mysteries of Glory</a>\s+)<a class="dropdown-item" href="light\.html">The Mysteries of Light</a>'
    $rosaryReplacement = '$1<a class="dropdown-item" href="sorrow.html">The Mysteries of Sorrow</a>'
    
    if ($content -match $rosaryPattern) {
        $content = $content -replace $rosaryPattern, $rosaryReplacement
        Write-Host "  Fixed duplicate 'light.html' in: $($file.Name)" -ForegroundColor Yellow
        $modified = $true
        $totalFixed++
    }
    
    # Standardize Rosary menu order (Joy, Light, Sorrow, Glory)
    $correctOrder = @'
               <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                <a class="dropdown-item" href="joy.html">The Mysteries of Joy</a>
                <a class="dropdown-item" href="light.html">The Mysteries of Light</a>
                <a class="dropdown-item" href="sorrow.html">The Mysteries of Sorrow</a>
                <a class="dropdown-item" href="glorious.html">The Mysteries of Glory</a>
              </div>
'@
    
    # Fix variations in Rosary menu
    $pattern1 = '(<a class="dropdown-item" href="joy\.html">The Mysteries of Joy</a>\s+)<a class="dropdown-item" href="sorrow\.html">The Mysteries of Sorrow</a>\s+<a class="dropdown-item" href="glorious\.html">The Mysteries of Glory</a>\s+<a class="dropdown-item" href="light\.html">The Mysteries of Light</a>'
    
    if ($content -match $pattern1) {
        $content = $content -replace $pattern1, '<a class="dropdown-item" href="joy.html">The Mysteries of Joy</a>
                <a class="dropdown-item" href="light.html">The Mysteries of Light</a>
                <a class="dropdown-item" href="sorrow.html">The Mysteries of Sorrow</a>
                <a class="dropdown-item" href="glorious.html">The Mysteries of Glory</a>'
        Write-Host "  Reordered Rosary mysteries in: $($file.Name)" -ForegroundColor Yellow
        $modified = $true
        $totalFixed++
    }
    
    if ($modified) {
        $content | Set-Content -Path $file.FullName -Encoding UTF8 -NoNewline
    }
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Total menu fixes applied: $totalFixed" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
