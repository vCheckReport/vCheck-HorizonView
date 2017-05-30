# Start of Settings
# End of Settings


$wrongsnapdesktops=@()
foreach ($pool in $pools){
$poolname=$pool.base.name
if ($pool.type -like "*automated*" -AND $pool.source -like "*VIEW_COMPOSER*"){

$poolmachines=get-hvmachine ($pool.base.name)
$wrongsnaps=$poolmachines | where {$_.managedmachinedata.viewcomposerdata.baseimagesnapshotpath -notlike  $pool.automateddesktopdata.VirtualCenternamesdata.snapshotpath -OR $_.managedmachinedata.viewcomposerdata.baseimagesnapshotpath -notlike $pool.automateddesktopdata.VirtualCenternamesdata.snapshotpath}
foreach ($wrongsnap in $wrongsnaps){
$wrongsnapdesktops+= New-Object PSObject -Property @{"VM Name" = $wrongsnap.base.name;
								"VM Snapshot" = $wrongsnap.managedmachinedata.viewcomposerdata.baseimagesnapshotpath;
								"VM GI" = $wrongsnap.managedmachinedata.viewcomposerdata.baseimagepath;
								"Pool Snapshot" = $pool.automateddesktopdata.VirtualCenternamesdata.snapshotpath;
								"Pool GI" = $pool.automateddesktopdata.VirtualCenternamesdata.parentvmpath;
}
}
}
}
$wrongsnapdesktops

$Title = "VDI Desktops based on wrong snapshot"
$Header = "VDI Desktops based on wrong snapshot"
$Comments = "These desktops have not been recomposed with the correct Golden Image Snapshot"
$Display = "Table"
$Author = "Wouter Kursten"
$PluginVersion = 0.1
$PluginCategory = "View"