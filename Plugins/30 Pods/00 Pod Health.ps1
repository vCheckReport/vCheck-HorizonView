# Start of Settings
# End of Settings
$pods=$services1.pod.pod_list() | where {$_.localpod -eq $false}
$podhealth=@()
foreach ($pod in $pods) {
	$endpoints=$services1.podhealth.podhealth_get($pod.id).data.endpointhealth
	foreach ($endpoint in $endpoints){
		$podhealth+= New-Object PSObject -Property @{"Remote_POD_Name" = $services1.pod.pod_get($pod.id) | select -expandproperty DisplayName
		"Endpoint_Name" = $endpoint.EndpointInfo | select -expandproperty Name;
		"Endpoint_Address" = $endpoint.EndpointInfo | select -expandproperty ServerAddress;
		"Status" = $endpoint.EndpointInfo | select -expandproperty Enabled;
		"State" = $endpoint | select -expandproperty State;
		"Roundtrip_Time" = $endpoint | select -expandproperty RoundTripTime;
}	
}	
}
$podhealth | select Remote_POD_Name,Endpoint_Name,Endpoint_Address,Status,State,Roundtrip_Time

$Title = "VDI Remote Pod Health"
$Header = "VDI Remote Pod Health"
$Comments = "This is the check to see if all Pod Communications are ok"
$Display = "Table"
$Author = "Wouter Kursten"
$PluginVersion = 0.1.1
$PluginCategory = "View"
