$adapters = Get-CimInstance Win32_NetworkAdapterConfiguration | Where-Object { $_.IPEnabled -eq $true }
$offlineadapters = Get-CimInstance Win32_NetworkAdapterConfiguration | Where-Object { $_.IPEnabled -eq $false}



function Get-NetworkInfo{
$netInfo = foreach ($a in $adapters) {
    [PSCustomObject]@{
        AdapterName  = $a.Description
        MACAddress   = $a.MACAddress
        IPv4Address  = ($a.IPAddress | Where-Object { $_ -match '\d+\.\d+\.\d+\.\d+' }) -join ', '
        IPv6Address  = ($a.IPAddress | Where-Object { $_ -match ':' }) -join ', '
        SubnetMask   = ($a.IPSubnet -join ', ')
        Gateway      = ($a.DefaultIPGateway -join ', ')
        DNS          = ($a.DNSServerSearchOrder -join ', ')
    }
}
$tcpListening = Get-NetTCPConnection | Where-Object { $_.State -eq 'Listen' } |
    Select-Object LocalAddress, LocalPort, OwningProcess
$udpListening = Get-NetUDPEndpoint |
    Select-Object LocalAddress, LocalPort, OwningProcess
$openPorts = $tcpListening + $udpListening
return [PSCustomObject]@{
    Adapters   = $netInfo
    OpenPorts  = $openPorts
    PortCount  = $openPorts.Count
}

}

function Get-NetworkInfoOffline{
$netInfoOffline = foreach ($a in $offlineadapters) {
    [PSCustomObject]@{
        AdapterName  = $a.Description
        MACAddress   = $a.MACAddress
    }
}
return $netInfoOffline
}
