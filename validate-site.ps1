# PowerShell script to validate all HTML files
$rootPath = "c:\xampp\htdocs\spconline"
Set-Location $rootPath

Write-Host "======================================" -ForegroundColor Cyan
Write-Host "COMPREHENSIVE SITE VALIDATION" -ForegroundColor Green
Write-Host "======================================" -ForegroundColor Cyan
Write-Host ""

$htmlFiles = Get-ChildItem -Path $rootPath -Filter "*.html" | Where-Object { $_.Name -ne "icon-generator.html" }

# 1. Check PWA CSS includes
Write-Host "1. Checking PWA CSS includes..." -ForegroundColor Yellow
$missingTheme = @()
$missingDarkMode = @()

foreach ($file in $htmlFiles) {
    $content = Get-Content -Path $file.FullName -Raw
    if ($content -notmatch 'css/theme\.css') {
        $missingTheme += $file.Name
    }
    if ($content -notmatch 'css/dark-mode\.css') {
        $missingDarkMode += $file.Name
    }
}

if ($missingTheme.Count -eq 0 -and $missingDarkMode.Count -eq 0) {
    Write-Host "   ✓ All $($htmlFiles.Count) pages have PWA CSS" -ForegroundColor Green
} else {
    if ($missingTheme.Count -gt 0) {
        Write-Host "   ✗ Missing theme.css: $($missingTheme.Count) files" -ForegroundColor Red
    }
    if ($missingDarkMode.Count -gt 0) {
        Write-Host "   ✗ Missing dark-mode.css: $($missingDarkMode.Count) files" -ForegroundColor Red
    }
}

# 2. Check PWA JavaScript includes
Write-Host ""
Write-Host "2. Checking PWA JavaScript includes..." -ForegroundColor Yellow
$missingAppJs = @()
$missingSearchJs = @()
$missingBookmarksJs = @()
$missingFontSizeJs = @()

foreach ($file in $htmlFiles) {
    $content = Get-Content -Path $file.FullName -Raw
    if ($content -notmatch 'js/app\.js') {
        $missingAppJs += $file.Name
    }
    if ($content -notmatch 'js/search\.js') {
        $missingSearchJs += $file.Name
    }
    if ($content -notmatch 'js/bookmarks\.js') {
        $missingBookmarksJs += $file.Name
    }
    if ($content -notmatch 'js/font-size\.js') {
        $missingFontSizeJs += $file.Name
    }
}

if ($missingAppJs.Count -eq 0 -and $missingSearchJs.Count -eq 0 -and $missingBookmarksJs.Count -eq 0 -and $missingFontSizeJs.Count -eq 0) {
    Write-Host "   ✓ All $($htmlFiles.Count) pages have PWA JavaScript" -ForegroundColor Green
} else {
    if ($missingAppJs.Count -gt 0) {
        Write-Host "   ✗ Missing app.js: $($missingAppJs.Count) files" -ForegroundColor Red
    }
    if ($missingSearchJs.Count -gt 0) {
        Write-Host "   ✗ Missing search.js: $($missingSearchJs.Count) files" -ForegroundColor Red
    }
}

# 3. Check PWA controls div
Write-Host ""
Write-Host "3. Checking PWA controls container..." -ForegroundColor Yellow
$missingControls = @()

foreach ($file in $htmlFiles) {
    $content = Get-Content -Path $file.FullName -Raw
    if ($content -notmatch '<div class="pwa-controls">') {
        $missingControls += $file.Name
    }
}

if ($missingControls.Count -eq 0) {
    Write-Host "   ✓ All $($htmlFiles.Count) pages have PWA controls div" -ForegroundColor Green
} else {
    Write-Host "   ✗ Missing PWA controls: $($missingControls.Count) files" -ForegroundColor Red
    $missingControls | ForEach-Object { Write-Host "     - $_" -ForegroundColor Red }
}

# 4. Check for broken links
Write-Host ""
Write-Host "4. Checking for broken links..." -ForegroundColor Yellow
$brokenLinks = @()

$problematicLinks = @(
    'ThreeO''ClockPrayer\.html',
    'TheRosary\.html',
    'UnfailingPrayertoSt\.Joseph\.html'
)

foreach ($file in $htmlFiles) {
    $content = Get-Content -Path $file.FullName -Raw
    foreach ($link in $problematicLinks) {
        if ($content -match $link) {
            $brokenLinks += "$($file.Name) has: $link"
        }
    }
}

if ($brokenLinks.Count -eq 0) {
    Write-Host "   ✓ No broken links found" -ForegroundColor Green
} else {
    Write-Host "   ✗ Found $($brokenLinks.Count) broken links" -ForegroundColor Red
    $brokenLinks | ForEach-Object { Write-Host "     - $_" -ForegroundColor Red }
}

# 5. Check for old yellow background
Write-Host ""
Write-Host "5. Checking for old styling (yellow background)..." -ForegroundColor Yellow
$yellowBg = @()

foreach ($file in $htmlFiles) {
    $content = Get-Content -Path $file.FullName -Raw
    if ($content -match "background-color:\s*lightyellow") {
        $yellowBg += $file.Name
    }
}

if ($yellowBg.Count -eq 0) {
    Write-Host "   ✓ No pages with old yellow background" -ForegroundColor Green
} else {
    Write-Host "   ✗ Found $($yellowBg.Count) pages with yellow background" -ForegroundColor Red
    $yellowBg | ForEach-Object { Write-Host "     - $_" -ForegroundColor Red }
}

# 6. Check menu consistency
Write-Host ""
Write-Host "6. Checking menu consistency..." -ForegroundColor Yellow
$duplicateRosary = @()

foreach ($file in $htmlFiles) {
    $content = Get-Content -Path $file.FullName -Raw
    # Check for duplicate light.html in Rosary menu
    if (($content -match "href=`"light\.html`".*?href=`"light\.html`"") -and ($content -match "The Mysteries of Light")) {
        $duplicateRosary += $file.Name
    }
}

if ($duplicateRosary.Count -eq 0) {
    Write-Host "   ✓ All menus are consistent" -ForegroundColor Green
} else {
    Write-Host "   ✗ Found $($duplicateRosary.Count) pages with duplicate menu items" -ForegroundColor Red
    $duplicateRosary | ForEach-Object { Write-Host "     - $_" -ForegroundColor Red }
}

# 7. Check PWA meta tags
Write-Host ""
Write-Host "7. Checking PWA meta tags..." -ForegroundColor Yellow
$missingManifest = @()

foreach ($file in $htmlFiles) {
    $content = Get-Content -Path $file.FullName -Raw
    if ($content -notmatch "manifest\.json") {
        $missingManifest += $file.Name
    }
}

if ($missingManifest.Count -eq 0) {
    Write-Host "   ✓ All $($htmlFiles.Count) pages have PWA manifest link" -ForegroundColor Green
} else {
    Write-Host "   ✗ Missing manifest link: $($missingManifest.Count) files" -ForegroundColor Red
}

# Summary
Write-Host ""
Write-Host "======================================" -ForegroundColor Cyan
Write-Host "VALIDATION SUMMARY" -ForegroundColor Green
Write-Host "======================================" -ForegroundColor Cyan
Write-Host "Total HTML files checked: $($htmlFiles.Count)" -ForegroundColor White
Write-Host ""

$totalIssues = $missingTheme.Count + $missingDarkMode.Count + $missingAppJs.Count + $missingSearchJs.Count + $missingControls.Count + $brokenLinks.Count + $yellowBg.Count + $duplicateRosary.Count + $missingManifest.Count

if ($totalIssues -eq 0) {
    Write-Host "✓ ALL CHECKS PASSED! Site is fully consistent." -ForegroundColor Green
} else {
    Write-Host "✗ Total issues found: $totalIssues" -ForegroundColor Red
    Write-Host "Please review the issues above." -ForegroundColor Yellow
}

Write-Host ""
