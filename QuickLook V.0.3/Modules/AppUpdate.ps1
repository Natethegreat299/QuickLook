. "$PSScriptRoot\InstalledApplications.ps1"

function Check-AppVersions {
    $appData = Get-Content "Assets\ApplicationVersions.json" | ConvertFrom-Json
    foreach ($a in $appData) {
        [PSCustomObject]@{
            Name    = $a.Name
            Version = $a.Version   # singular here
        }
    }
}

function Compare-AppVersions {
    $upToDate = Check-AppVersions
    $installedApps = Get-InstalledApps

   
    $opSkip = (Read-Host "Skip all updates? (Y/N)").ToUpper()
    if ($opSkip -eq 'Y') {
        Write-Host "Skipping all updates."
        return
    }

    foreach ($a in $upToDate) {
        $match = $installedApps | Where-Object { $_.Name -like "*$($a.Name)*" }

        if ($match) {
            Write-Host "$($a.Name): Installed $($match.Version), Expected $($a.Version)"

            try {
                if ([version]$match.Version -ne [version]$a.Version) {
                    Write-Host "→ Version differs"
                    $choice = (Read-Host "Update $($a.Name)? (Y/N)").ToUpper()
                    if ($choice -eq 'Y') {
                        winget upgrade --name $($a.Name) --accept-source-agreements --accept-package-agreements
                    }
                } else {
                    Write-Host "→ Version matches"
                }
            } catch {
                Write-Host "→ Couldn't compare versions (format issue)"
            }
        } else {
            Write-Host "$($a.Name): Not installed"
        }
    }
}


