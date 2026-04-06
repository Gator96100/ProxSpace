<#
.SYNOPSIS
    Build Proxmark3 firmware and client using ProxSpace MSYS2 environment.
.DESCRIPTION
    PowerShell wrapper that sets correct environment variables (TMP, TEMP,
    CC, CXX, MINGW_HOME) before invoking the MSYS2 make toolchain.
    Avoids the /tmp -> C:\WINDOWS\ path translation bug that occurs when
    building from git-bash or other non-MSYS2 shells.
.PARAMETER ProxSpacePath
    Path to ProxSpace root. Default: directory containing this script.
.PARAMETER PM3Path
    Path to Proxmark3 source. Default: {ProxSpacePath}\pm3
.PARAMETER Target
    Make target. Default: 'all' (bootrom + firmware + client).
    Use 'client' for client-only builds.
.PARAMETER Jobs
    Parallel make jobs. Default: CPU core count.
.PARAMETER Flash
    After a successful build, flash bootrom then fullimage to the device.
.PARAMETER Port
    COM port for flashing. Default: auto-detect (first Proxmark3 VID).
.EXAMPLE
    .\Build-Proxmark3.ps1
    .\Build-Proxmark3.ps1 -Flash -Port COM5
    .\Build-Proxmark3.ps1 -Target client -Jobs 8
#>
[CmdletBinding()]
param(
    [string]$ProxSpacePath = $PSScriptRoot,
    [string]$PM3Path = "",
    [string]$Target = "all",
    [int]$Jobs = [Environment]::ProcessorCount,
    [switch]$Flash,
    [string]$Port = ""
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

if (-not $PM3Path) { $PM3Path = Join-Path $ProxSpacePath "pm3" }

# --- Pre-flight checks ---
$make = Join-Path $ProxSpacePath "msys2\usr\bin\make.exe"
$bash = Join-Path $ProxSpacePath "msys2\usr\bin\bash.exe"
$gcc  = Join-Path $ProxSpacePath "msys2\mingw64\bin\gcc.exe"
$armgcc = Join-Path $ProxSpacePath "msys2\mingw64\bin\arm-none-eabi-gcc.exe"

foreach ($tool in @($make, $bash, $gcc)) {
    if (-not (Test-Path $tool)) {
        throw "Required tool not found: $tool — is ProxSpace installed at $ProxSpacePath?"
    }
}
if (-not (Test-Path $PM3Path)) {
    throw "Proxmark3 source not found at $PM3Path. Clone it with: git clone https://github.com/RfidResearchGroup/proxmark3.git $PM3Path"
}

# --- Inject env vars ---
# These override any inherited Windows env vars that would confuse MSYS2/MinGW
$msysTmp = Join-Path $ProxSpacePath "msys2\tmp"
$null = New-Item -ItemType Directory -Force -Path $msysTmp

$env:TEMP       = $msysTmp
$env:TMP        = $msysTmp
$env:MINGW_HOME = Join-Path $ProxSpacePath "msys2\mingw64"
$env:CC         = $gcc
$env:CXX        = Join-Path $ProxSpacePath "msys2\mingw64\bin\g++.exe"
$env:MSYSTEM    = "MINGW64"
$env:PATH       = "{0}\msys2\mingw64\bin;{0}\msys2\usr\bin;{1}" -f $ProxSpacePath, $env:PATH

Write-Host "=== Proxmark3 Build ==="
Write-Host "  ProxSpace : $ProxSpacePath"
Write-Host "  PM3 source: $PM3Path"
Write-Host "  Target    : $Target"
Write-Host "  Jobs      : $Jobs"
Write-Host ""

# --- Build ---
$makeArgs = @("-j$Jobs", "SKIPREVENGTEST=1")
if ($Target -eq "all") {
    # Build bootrom, firmware, and client sequentially
    foreach ($t in @("bootrom/all", "armsrc/all")) {
        Write-Host "[*] Building $t ..."
        & $make -C $PM3Path $t @makeArgs
        if ($LASTEXITCODE -ne 0) { throw "Build failed at target: $t (exit $LASTEXITCODE)" }
    }
    Write-Host "[*] Building client ..."
    & $make -C $PM3Path "client" @makeArgs
    if ($LASTEXITCODE -ne 0) { throw "Client build failed (exit $LASTEXITCODE)" }
} else {
    Write-Host "[*] Building $Target ..."
    & $make -C $PM3Path $Target @makeArgs
    if ($LASTEXITCODE -ne 0) { throw "Build failed at target: $Target (exit $LASTEXITCODE)" }
}

Write-Host ""
Write-Host "[+] Build succeeded."

# --- Flash (optional) ---
if ($Flash) {
    $client = Join-Path $PM3Path "client\proxmark3.exe"
    if (-not (Test-Path $client)) { throw "proxmark3.exe not found — build may be incomplete." }

    # Auto-detect COM port if not specified
    if (-not $Port) {
        $pm3Device = Get-PnpDevice -Class 'Ports' -Status OK -ErrorAction SilentlyContinue |
            Where-Object { $_.InstanceId -match '9AC4' } |
            Select-Object -First 1
        if ($pm3Device -and $pm3Device.FriendlyName -match 'COM(\d+)') {
            $Port = "COM$($Matches[1])"
            Write-Host "[*] Auto-detected Proxmark3 on $Port"
        } else {
            throw "No Proxmark3 detected. Specify -Port manually."
        }
    }

    Write-Host "[*] Flashing bootrom to $Port ..."
    & $client $Port --flash --unlock-bootloader --image (Join-Path $PM3Path "bootrom\obj\bootrom.elf")
    if ($LASTEXITCODE -ne 0) { throw "Bootrom flash failed." }

    Write-Host "[*] Waiting 5s for device to re-enumerate ..."
    Start-Sleep -Seconds 5

    # Re-detect port (may change after bootloader update)
    $pm3Device = Get-PnpDevice -Class 'Ports' -Status OK -ErrorAction SilentlyContinue |
        Where-Object { $_.InstanceId -match '9AC4' } |
        Select-Object -First 1
    if ($pm3Device -and $pm3Device.FriendlyName -match 'COM(\d+)') {
        $newPort = "COM$($Matches[1])"
        if ($newPort -ne $Port) {
            Write-Host "[!] Port changed from $Port to $newPort after bootloader flash"
            $Port = $newPort
        }
    }

    Write-Host "[*] Flashing fullimage to $Port ..."
    & $client $Port --flash --image (Join-Path $PM3Path "armsrc\obj\fullimage.elf")
    if ($LASTEXITCODE -ne 0) { throw "Fullimage flash failed." }

    Write-Host ""
    Write-Host "[+] Flash complete. Verify with: proxmark3.exe $Port -c 'hw version'"
}
