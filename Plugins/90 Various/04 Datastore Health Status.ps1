# Start of Settings
# End of Settings

$DatastoreHealthoverview=@()
$VirtualCenterHealthlist=$services1.VirtualCenterHealth.VirtualCenterHealth_list()
foreach ($VirtualCenterHealth in $VirtualCenterHealthlist){
	$Name=$VirtualCenterHealth.data.name
	foreach ($Datastore in $VirtualCenterHealthlist.datastoreData){
		$DatastoreHealthoverview+=New-Object PSObject -Property @{
		"Name" = $Name;
		"Datastore" = $ESXiHost.name;
		"accessible" = $ESXiHost.accessible;
		"path" = $ESXiHost.path;
		"datastoreType" = $ESXiHost.datastoreType;
		"capacityMB" = $ESXiHost.capacityMB;
		"freeSpaceMB" = $ESXiHost.freeSpaceMB;
		}
	}
}

$DatastoreHealthoverview | select-object Name,Datastore,accessible,path,datastoreType,capacityMB,freeSpaceMB | sort-object name

$Title = "Datastore Health Overview"
$Header = "Datastore Health Overview"
$Comments = "This shows the health for every datastore."
$Display = "Table"
$Author = "Wouter Kursten"
$PluginVersion = 0.1
$PluginCategory = "View"