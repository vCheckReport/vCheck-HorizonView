# Start of Settings
# End of Settings

$VirtualCenterHealthoverview=@()
$VirtualCenterHealthlist=$services1.VirtualCenterHealth.VirtualCenterHealth_list()
foreach ($VirtualCenterHealth in $VirtualCenterHealthlist){
	$Name=$VirtualCenterHealth.data.name
	$version=$VirtualCenterHealth.data.version
	$build=$VirtualCenterHealth.data.build
	$apiVersion=$VirtualCenterHealth.data.apiVersion
	foreach ($Connectionserver in $VirtualCenterHealthlist.connectionServerData){
		$VirtualCenterHealthoverview+=New-Object PSObject -Property @{
		"name" = $Name;
		"version"=$version;
		"build"=$build;
		"apiVersion"=$apiVersion;
		"Connectionserver" = $Connectionserver.name;
		"Status" = $Connectionserver.Status;
		"thumbprintAccepted" = $Connectionserver.thumbprintAccepted;
		"certificateHealth" = $Connectionserver.certificateHealth;
		}
	}
}

$VirtualCenterHealthoverview | select-object name,version,build,apiVersion,Connectionserver,Status,thumbprintAccepted,certificateHealth

$Title = "vCenter Health Overview"
$Header = "vCenter Health Overview"
$Comments = "This shows the health for every vCenter from every connectionserver."
$Display = "Table"
$Author = "Wouter Kursten"
$PluginVersion = 0.1
$PluginCategory = "View"