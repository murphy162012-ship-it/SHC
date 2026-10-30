$ErrorActionPreference = 'Stop'
$ProjectDir = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $ProjectDir

Write-Host ''
Write-Host '========================================' -ForegroundColor Magenta
Write-Host '       SHC - Windows PowerShell Build' -ForegroundColor Magenta
Write-Host '========================================' -ForegroundColor Magenta
Write-Host ''

# Check that Java 25 is installed and available on PATH.
$Java = Get-Command java -ErrorAction SilentlyContinue
if (-not $Java) {
    Write-Host 'Java was not found. Install JDK 25, then run this file again.' -ForegroundColor Red
    Read-Host 'Press Enter to close'
    exit 1
}

$PreviousErrorActionPreference = $ErrorActionPreference
$ErrorActionPreference = 'Continue'
$JavaVersionOutput = (& java -version 2>&1 | Out-String)
$ErrorActionPreference = $PreviousErrorActionPreference
if ($JavaVersionOutput -notmatch '"25([.+-]|\")') {
    Write-Host 'Java 25 was not detected. SHC targets JDK 25.' -ForegroundColor Red
    Write-Host $JavaVersionOutput
    Read-Host 'Press Enter to close'
    exit 1
}

# Download Gradle automatically if it is not already installed.
$GradleVersion = '9.8.2'
$GradleHome = Join-Path $env:LOCALAPPDATA "SHC\gradle-$GradleVersion"
$GradleExe = Join-Path $GradleHome 'bin\gradle.bat'

if (-not (Test-Path $GradleExe)) {
    $InstallRoot = Join-Path $env:LOCALAPPDATA 'SHC'
    $ZipPath = Join-Path $InstallRoot "gradle-$GradleVersion-bin.zip"
    New-Item -ItemType Directory -Force -Path $InstallRoot | Out-Null

    Write-Host "Downloading Gradle $GradleVersion (first run only)..." -ForegroundColor Cyan
    $DownloadUrl = "https://services.gradle.org/distributions/gradle-$GradleVersion-bin.zip"
    Invoke-WebRequest -Uri $DownloadUrl -OutFile $ZipPath

    Write-Host 'Installing Gradle...' -ForegroundColor Cyan
    Expand-Archive -LiteralPath $ZipPath -DestinationPath $InstallRoot -Force
    Remove-Item -LiteralPath $ZipPath -Force
}

if (-not (Test-Path $GradleExe)) {
    Write-Host 'Gradle could not be installed. Check your internet connection and try again.' -ForegroundColor Red
    Read-Host 'Press Enter to close'
    exit 1
}

Write-Host 'Building SHC. This can take a while on the first run...' -ForegroundColor Cyan
& $GradleExe --no-daemon build
if ($LASTEXITCODE -ne 0) {
    Write-Host ''
    Write-Host 'Build failed. Take a screenshot of this window and send it to ChatGPT.' -ForegroundColor Red
    Read-Host 'Press Enter to close'
    exit $LASTEXITCODE
}

$OutputDir = Join-Path $ProjectDir 'build\libs'
Write-Host ''
Write-Host 'Build finished. Check the JAR in:' -ForegroundColor Green
Write-Host $OutputDir -ForegroundColor Yellow
if (Test-Path $OutputDir) {
    Start-Process explorer.exe -ArgumentList $OutputDir
}
Read-Host 'Press Enter to close'
