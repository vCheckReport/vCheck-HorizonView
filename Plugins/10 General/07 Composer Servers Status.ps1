# Start of Settings
# End of Settings

$comserverstatus=@()
$comservers=$services1.viewcomposerhealth.viewcomposerhealth_list()
foreach ($comserver in $comservers) {
$vcenters=$comserver.data.virtualcenters

foreach ($vcenter in $vcenters){
if ($vcenternames){
$vcenternames+=","
$vcenternames+=($services1.virtualcenterhealth.virtualcenterhealth_get($vcenter)).data.name
}
else{
$vcenternames+=($services1.virtualcenterhealth.virtualcenterhealth_get($vcenter)).data.name
}
}
$comserverstatus+=New-Object PSObject -Property @{"Name" = $comserver.ServerName;
								"Version" = $comserver.Data.Version;
								"Build" = $comserver.Data.Build;
								"vCenter_Server"= $vcenternames
								
}
}
$comserverstatus | select name,Version,Build,vcenter_server

$Title = "Composer Servers Status"
$Header = "Composer Servers Status"
$Comments = "These are the used Composer Servers"
$Display = "Table"
$Author = "Wouter Kursten"
$PluginVersion = 0.1
$PluginCategory = "View"