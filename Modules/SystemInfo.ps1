function Get-SystemInfo {
    try {
        $os = Get-CimInstance Win32_OperatingSystem
        $cpu = Get-CimInstance Win32_Processor
        $bios = Get-CimInstance Win32_BIOS
        $serialn = $bios.SerialNumber
        $ramBytes = (Get-CimInstance Win32_PhysicalMemory | Measure-Object -Property Capacity -Sum).Sum
        $ramGB = [math]::Round($ramBytes / 1GB, 2)
        $sysstuff = Get-CimInstance Win32_ComputerSystem
        $model2 = $sysstuff.Model
        $systype = $sysstuff.SystemType
        $gpu = (Get-CimInstance Win32_VideoController | Select-Object -First 1 Name).Name
        $uptime = (Get-Date) - $os.LastBootUpTime

        return [PSCustomObject]@{
            ComputerName = $env:COMPUTERNAME
            UserName     = $env:USERNAME
            OS           = $os.Caption
            Version      = $os.Version
            Architecture = $os.OSArchitecture
            CPU          = $cpu.Name
            Cores        = $cpu.NumberOfCores
            RAM_GB       = $ramGB
            Manufacturer = $sysstuff.Manufacturer
            Model        = $model2
            SystemType   = $systype
            BIOS         = $bios.SMBIOSBIOSVersion
            Serial       = $serialn
            BootTime     = $os.LastBootUpTime
            InstallDate  = $os.InstallDate
            GPU          = $gpu
            Domain       = $sysstuff.Domain
            Uptime = "{0} Days {1} Hours {2} Minutes" -f $uptime.Days, $uptime.Hours, $uptime.Minutes

        }
    }
    catch {
        Write-Warning "Error collecting system info: $_"
    }
}
