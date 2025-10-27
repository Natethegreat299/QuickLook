$compsStat = Get-MpComputerStatus
$firewall = Get-NetFirewallProfile

function Get-SecurityInfo {

    # --- Defender Section ---
    $defenderInfo = [PSCustomObject]@{
        AntivirusEnabled      = $compsStat.AntivirusEnabled
        SignatureOutOfDate    = $compsStat.DefenderSignaturesOutOfDate
        LastSignatureUpdate   = $compsStat.AntivirusSignatureLastUpdated
        SignatureVersion      = $compsStat.AntivirusSignatureVersion
        RealTimeProtection    = $compsStat.RealTimeProtectionEnabled
        TamperProtected       = $compsStat.IsTamperProtected
        LastFullScan          = $compsStat.FullScanEndTime
        LastQuickScan         = $compsStat.QuickScanEndTime
        EngineVersion         = $compsStat.AMEngineVersion
    }

    # --- Firewall Section ---
    $firewallInfo = foreach ($f in $firewall) {
        [PSCustomObject]@{
            ProfileName        = $f.Name
            FirewallEnabled    = $f.Enabled
            DefaultInbound     = $f.DefaultInboundAction
            DefaultOutbound    = $f.DefaultOutboundAction
            AllowInboundRules  = $f.AllowInboundRules
        }
    }
try {
    $SecureBootEnabled = Confirm-SecureBootUEFI
} catch {
    $SecureBootEnabled = "Not Supported"
}

$secureBootInfo = [PSCustomObject]@{
    SecureBoot = $SecureBootEnabled
}

    $securityInfo = @($defenderInfo) + $firewallInfo + $secureBootInfo
    return $securityInfo
}

