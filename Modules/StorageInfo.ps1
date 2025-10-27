$physDisk = Get-PhysicalDisk
$volumes = Get-Volume
$partition = Get-Partition

function Get-DiskInfoPhysical{
    foreach ($d in $physDisk) {
        [PSCustomObject]@{
            DiskName = $d.FriendlyName
            Health = $d.HealthStatus
            MediaType = $d.MediaType

        }
    }    
}

function Get-DiskInfoVolume{
    foreach ($v in $volumes) {
        [PSCustomObject]@{
            DriveLetter = $v.DriveLetter
            FileSystem = $v.FileSystemType
            Status = $v.OperationalStatus
            SizeRemaining = $v.SizeRemaining
        }
    }
}

function Get-PartitionInfo {
    foreach ($p in $partition) {
        [PSCustomObject]@{
            PartitionNumber = $p.PartitionNumber
            DriveLetter = $p.DriveLetter
            Size = $p.Size
            Type = $p.Type
        }
    }
}

function Get-StorageInfo {
    $physical = Get-DiskInfoPhysical
    $volumes  = Get-DiskInfoVolume
    $part = Get-PartitionInfo

    return @{
        Physical = $physical
        Volumes  = $volumes
        Partitions = $part
    }
}

Get-StorageInfo