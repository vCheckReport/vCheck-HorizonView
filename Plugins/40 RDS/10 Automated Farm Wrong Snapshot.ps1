# Start of Settings
# End of Settings


$wrongsnapdesktops=@()
foreach ($farm in $farms){
	$farmname=$farm.data.name

	if ($farm.type -like "*automated*"){
		$farmID=($farm).id
		$queryservice=new-object vmware.hv.queryserviceservice
		$defn = New-Object VMware.Hv.QueryDefinition
		$defn.queryentitytype='RDSServerInfo'

		$defn.filter = New-Object VMware.Hv.QueryFilterEquals -Property @{ 'memberName' = 'base.farm'; 'value' = $farm.ID }

		$queryResults = $queryService.QueryService_Create($Services1, $defn)
        #$farmmachines=$services1.machine.machine_getinfos($queryResults.results.id)
        $farmmachines=$queryResults.Results
		$wrongsnaps=$farmmachines | where {$_.rdsservermaintenancedata.baseimagesnapshotpath -notlike  $farm.automatedfarmdata.VirtualCenternamesdata.snapshotpath -OR $_.rdsservermaintenancedata.baseimagepath -notlike $farm.automatedfarmdata.VirtualCenternamesdata.parentvmpath}
		if ($wrongsnaps){
			foreach ($wrongsnap in $wrongsnaps){
				$wrongsnapdesktops+= New-Object PSObject -Property @{
					"RDS Name" = $wrongsnap.base.name;
					"VM Snapshot" = $wrongsnap.rdsservermaintenancedata.baseimagesnapshotpath;
					"VM GI" = $wrongsnap.rdsservermaintenancedata.baseimagepath;
					"Farm Snapshot" = $farm.automatedfarmdata.VirtualCenternamesdata.snapshotpath;
					"Farm GI" = $farm.automatedfarmdata.VirtualCenternamesdata.parentvmpath;
				}
			}
		
		}
		$services1.QueryService.QueryService_DeleteAll()
	}
}
$wrongsnapdesktops

$Title = "RDS Farms based on wrong snapshot"
$Header = "RDS Farms based on wrong snapshot"
$Comments = "These farms have not been rebuild with the correct Golden Image Snapshot"
$Display = "Table"
$Author = "Wouter Kursten"
$PluginVersion = 0.1
$PluginCategory = "View"
