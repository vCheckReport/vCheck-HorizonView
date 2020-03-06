# Start of Settings
# End of Settings


$wrongsnapdesktops=@()
foreach ($pool in $pools){
	$poolname=$pool.base.name

	if ($pool.type -like "*automated*"){
		$PoolID=($pool).id
		$queryservice=new-object vmware.hv.queryserviceservice
		$defn = New-Object VMware.Hv.QueryDefinition
		$defn.queryentitytype='MachineSummaryView'

		$defn.filter = New-Object VMware.Hv.QueryFilterEquals -Property @{ 'memberName' = 'base.desktop'; 'value' = $pool.id }

		$queryResults = $queryService.QueryService_Create($Services1, $defn)
		$poolmachines=$services1.machine.machine_getinfos($queryResults.results.id)
		$wrongsnaps=$poolmachines | where {$_.managedmachinedata.viewcomposerdata.baseimagesnapshotpath -notlike  $pool.automateddesktopdata.VirtualCenternamesdata.snapshotpath -OR $_.managedmachinedata.viewcomposerdata.baseimagepath -notlike $pool.automateddesktopdata.VirtualCenternamesdata.parentvmpath}
		if ($wrongsnaps){
			foreach ($wrongsnap in $wrongsnaps){
				$wrongsnapdesktops+= New-Object PSObject -Property @{
					"VM Name" = $wrongsnap.base.name;
					"VM Snapshot" = $wrongsnap.managedmachinedata.viewcomposerdata.baseimagesnapshotpath;
					"VM GI" = $wrongsnap.managedmachinedata.viewcomposerdata.baseimagepath;
					"Pool Snapshot" = $pool.automateddesktopdata.VirtualCenternamesdata.snapshotpath;
					"Pool GI" = $pool.automateddesktopdata.VirtualCenternamesdata.parentvmpath;
				}
			}
		
		}
		$services1.QueryService.QueryService_DeleteAll()
	}
}
$wrongsnapdesktops

$Title = "VDI Desktops based on wrong snapshot"
$Header = "VDI Desktops based on wrong snapshot"
$Comments = "These desktops have not been recomposed with the correct Golden Image Snapshot"
$Display = "Table"
$Author = "Wouter Kursten"
$PluginVersion = 0.4
$PluginCategory = "View"
