# Start of Settings
# End of Settings

$fulldesktopassignment=@()
foreach ($pool in $pools){
$poolname=$pool.base.name
if ($pool.type -like "*automated*" -AND $pool.source -like "*VIRTUAL_CENTER*"){
	$desktops=get-hvmachinesummary -pool $poolname
	foreach ($desktop in $desktops){
	if ($desktop.namesdata.username){
		$username=$desktop.namesdata.username
		}
	else{
		$username="Unassigned"
		}
$fulldesktopassignment+=New-Object PSObject -Property @{"Pool_Name" = $Poolname;
								"Desktop_Name" = $desktop.base.name;
								"Desktop_State" = $desktop.base.basicstate;
								"Desktop_Assigned_to" = $username;
								"Desktop_OperatingSystem" = $desktop.base.Operatingsystem;
								"Agent_version" = $desktop.base.agentversion;
								"Host" = $desktop.managedmachinesdata.hostname;
								"Datastore" = $desktop.ManagedMachineNamesData.datastorepaths | out-string;
}
}
}
}
$fulldesktopassignment | select Pool_Name,Desktop_Name,Desktop_State,Desktop_Assigned_to,Desktop_OperatingSystem,Agent_version,Host,Datastore
$Title = "Dedicated Desktop Pool Assignment"
$Header = "Dedicated Desktop Pool Assignment"
$Comments = "These are the dedicated desktops with their current user assignment"
$Display = "Table"
$Author = "Wouter Kursten"
$PluginVersion = 0.1
$PluginCategory = "View"