$paths = @(
    "HKCU:\Software\Classes\Directory\shell\OpenInOpenCode"
    "HKCU:\Software\Classes\Directory\Background\shell\OpenInOpenCode"
)
foreach ($p in $paths) {
    if (Test-Path $p) {
        Remove-Item -Path $p -Recurse -Force
    }
}
Write-Host "Open in OpenCode removed from the context menu." -ForegroundColor Green
