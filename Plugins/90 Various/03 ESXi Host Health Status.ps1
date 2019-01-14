# Start of Settings
# End of Settings

$ESXiHealthoverview=@()
$VirtualCenterHealthlist=$services1.VirtualCenterHealth.VirtualCenterHealth_list()
foreach ($VirtualCenterHealth in $VirtualCenterHealthlist){
	$Name=$VirtualCenterHealth.data.name
	foreach ($ESXiHost in $VirtualCenterHealthlist.hostData){
		$vGPUTypes= [system.String]::Join(",", $ESXiHost.vGPUTypes)
		$ESXiHealthoverview+=New-Object PSObject -Property @{
		"Name" = $Name;
		"ESXi_Host" = $ESXiHost.name;
		"Version" = $ESXiHost.version;
		"apiVersion" = $ESXiHost.apiVersion;
		"status" = $ESXiHost.status;
		"clusterName" = $ESXiHost.clusterName;
		"vGPUTypes" = $vGPUTypes;
		}
	}
}

$ESXiHealthoverview | select-object Name,ESXi_Host,Version,apiVersion,Status,clusterName,vGPUTypes | sort-object name,Clustername,ESXi_Host

$Title = "ESXi Host Health Overview"
$Header = "ESXi Host Health Overview"
$Comments = "This shows the health for every ESXi host."
$Display = "Table"
$Author = "Wouter Kursten"
$PluginVersion = 0.1
$PluginCategory = "View"