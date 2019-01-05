# Start of Settings
# End of Settings


$wrongsnapdesktops=@()
foreach ($pool in $pools){
	$poolname=$pool.base.name

	if ($pool.type -like "*automated*"){
		$queryservice=new-object vmware.hv.queryserviceservice
		$defn = New-Object VMware.Hv.QueryDefinition
		$defn.queryentitytype='MachineSummaryView'
		$filter = New-Object VMware.Hv.QueryFilterEquals -Property @{ 'memberName' = 'base.name'; 'value' = "$pool.base.name" }
		$queryResults = $queryService.QueryService_Create($Services1, $defn)
		$poolmachines=$queryResults.results
		$wrongsnaps=$poolmachines | where {$_.managedmachinedata.viewcomposerdata.baseimagesnapshotpath -notlike  $pool.automateddesktopdata.VirtualCenternamesdata.snapshotpath -OR $_.managedmachinedata.viewcomposerdata.baseimagepath -notlike $pool.automateddesktopdata.VirtualCenternamesdata.parentvmpath}
		foreach ($wrongsnap in $wrongsnaps){
			$wrongsnapdesktops+= New-Object PSObject -Property @{
				"VM Name" = $wrongsnap.base.name;
				"VM Snapshot" = $wrongsnap.managedmachinedata.viewcomposerdata.baseimagesnapshotpath;
				"VM GI" = $wrongsnap.managedmachinedata.viewcomposerdata.baseimagepath;
				"Pool Snapshot" = $pool.automateddesktopdata.VirtualCenternamesdata.snapshotpath;
				"Pool GI" = $pool.automateddesktopdata.VirtualCenternamesdata.parentvmpath;
			}
		$services1.QueryService.QueryService_DeleteAll()
		}
	}
}
$wrongsnapdesktops

$Title = "VDI Desktops based on wrong snapshot"
$Header = "VDI Desktops based on wrong snapshot"
$Comments = "These desktops have not been recomposed with the correct Golden Image Snapshot"
$Display = "Table"
$Author = "Wouter Kursten"
$PluginVersion = 0.3
$PluginCategory = "View"
