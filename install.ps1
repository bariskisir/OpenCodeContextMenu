if (Get-Command opencode-cli -ErrorAction SilentlyContinue) {
    $cli = "opencode-cli"
} elseif (Get-Command opencode -ErrorAction SilentlyContinue) {
    $cli = "opencode"
} else {
    Write-Host "OpenCode CLI not found." -ForegroundColor Red; exit 1
}
$paths = @(
    "HKCU:\Software\Classes\Directory\shell\OpenInOpenCode"
    "HKCU:\Software\Classes\Directory\Background\shell\OpenInOpenCode"
)
foreach ($p in $paths) {
    $commandPath = "$p\command"
    $desiredCommand = "cmd.exe /k ""cd /d ""%V"" && $cli"""
    $existingCommand = (Get-ItemProperty -Path $commandPath -Name "(Default)" -ErrorAction SilentlyContinue)."(Default)"
    if ($existingCommand -eq $desiredCommand) { continue }
    New-Item -Path $commandPath -Force | Out-Null
    Set-ItemProperty -Path $p -Name "(Default)" -Value "Open in OpenCode"
    Set-ItemProperty -Path $p -Name "Icon" -Value "$cli,0"
    Set-ItemProperty -Path $commandPath -Name "(Default)" -Value $desiredCommand
}
Write-Host "Open in OpenCode added to the context menu." -ForegroundColor Green
