# Install-AllRuntimes-(RunAdmin!).ps1
# Run as Administrator

$rootPath = $PSScriptRoot
$logFile = Join-Path $rootPath "Install-Log.txt"

function Write-Log {
    param([string]$Message)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$timestamp - $Message" | Out-File -FilePath $logFile -Append -Encoding utf8
    Write-Host "$timestamp - $Message"
}

Write-Log "Starting final installation run v3 from: $rootPath"

# .NET section
$netFolder = Join-Path $rootPath ".Net"
Write-Log "About to check .NET folder"
if (Test-Path $netFolder) {
    Write-Log "Entering .NET section"
    Get-ChildItem -Path $netFolder -Filter "*.exe" | ForEach-Object {
        $file = $_.FullName
        $name = $_.Name
        $args = "/quiet /norestart"

        if ($name -match "dotnet-win-x(64|86)\.[01]\.[01]") { $args = "/q /norestart" }
        elseif ($name -match "dotnet-runtime-2\.[012]") { $args = "/quiet /norestart" }

        Write-Log "Installing .NET: $name → $args"
        try {
            Start-Process -FilePath $file -ArgumentList $args -Wait -NoNewWindow
            Write-Log "Completed .NET: $name"
        } catch {
            Write-Log "Error in .NET ${name}: $_"
        }
    }
    Write-Log ".NET section finished"
} else {
    Write-Log "No .Net folder"
}

# VC++ section - with fixed flag for 2005
$vcFolder = Join-Path $rootPath "Visual Studio (VC++)"
Write-Log "About to check VC++ folder"
if (Test-Path $vcFolder) {
    Write-Log "Entering VC++ section"
    Get-ChildItem -Path $vcFolder -Filter "*.exe" | ForEach-Object {
        $file = $_.FullName
        $name = $_.Name
        $args = "/quiet /norestart"

        if ($name -match "2005") { 
            $args = "/Q"  # Special for 2005 - capital Q for full silent
        } elseif ($name -match "2008|2010|2012|2013") {
            $args = "/q /norestart"
        }

        Write-Log "Installing VC++: $name → $args"
        try {
            Start-Process -FilePath $file -ArgumentList $args -Wait -NoNewWindow
            Write-Log "Completed VC++: $name"
        } catch {
            Write-Log "Error in VC++ ${name}: $_"
        }
    }
    Write-Log "VC++ section finished"
} else {
    Write-Log "No VC++ folder"
}

Write-Log "Script reached the end successfully"
Write-Host "Done - see Install-Log.txt" -ForegroundColor Green
Write-Host "Confirm everything installed correctly via Windows key + S > search; "Installed Apps" > (sort by date installed) > Confirm" -ForegroundColor Green