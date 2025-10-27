$installedApps = Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate

function Get-InstalledApps {
    $installedApps = Get-ItemProperty `
        HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*, `
        HKLM:\Software\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*, `
        HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |
        Where-Object { $_.DisplayName } |
        Select-Object DisplayName, DisplayVersion, Publisher, InstallDate

    $appList = foreach ($I in $installedApps) {
        [PSCustomObject]@{
            Name        = $I.DisplayName
            Version     = $I.DisplayVersion
            Publisher   = $I.Publisher
            InstallDate = $I.InstallDate
        }
    }

    return $appList
}



