# PowerShell script to fix all broken links across all HTML files
$rootPath = "c:\xampp\htdocs\spconline"
Set-Location $rootPath

Write-Host "Fixing broken links across all HTML files..." -ForegroundColor Green
Write-Host ""

$htmlFiles = Get-ChildItem -Path $rootPath -Filter "*.html"

$fixes = @(
    @{Old = "ThreeO'ClockPrayer\.html"; New = "ThreeOClockPrayer.html"; Name = "Three O'Clock Prayer link"},
    @{Old = "TheRosary\.html"; New = "joy.html"; Name = "TheRosary link to joy.html"},
    @{Old = "UnfailingPrayertoSt\.Joseph\.html"; New = "UnfailingPrayertoStJoseph.html"; Name = "Unfailing Prayer to St. Joseph link"}
)

$totalFixed = 0

foreach ($file in $htmlFiles) {
    $content = Get-Content -Path $file.FullName -Raw -Encoding UTF8
    $modified = $false
    
    foreach ($fix in $fixes) {
        if ($content -match $fix.Old) {
            $content = $content -replace $fix.Old, $fix.New
            $modified = $true
            Write-Host "  Fixed in $($file.Name): $($fix.Name)" -ForegroundColor Yellow
            $totalFixed++
        }
    }
    
    if ($modified) {
        $content | Set-Content -Path $file.FullName -Encoding UTF8 -NoNewline
    }
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Total fixes applied: $totalFixed" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
