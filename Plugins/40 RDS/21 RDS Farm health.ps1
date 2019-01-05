# Start of Settings
# End of Settings


$farmhealth=@()

foreach ($farm in $farms){
	$health=$services1.Farmhealth.farmhealth_get($farm.id)
	$farmhealthstatus=$health.health
	$farmname=$farm.data.name
	foreach ($rdsserver in $health.RdsServerHealth){
		if ($rdsserver.missingapplications){
			$missingapps=$a = [system.String]::Join(",", $rdsserver.missingapplications.name)
		}
		$farmhealth+=New-Object PSObject -Property @{
			"FarmName" = $farmname;
			"FarmHealth" = $farmhealthstatus;
			"RDS_Hostname" = $rdsserver.name;
			"RDS_Status" = $rdsserver.status;
			"RDS_health" = $rdsserver.health;
			"RDS_Available" = $rdsserver.available;
			"RDS_Missing_Apps" = $missingapps;
			"RDS_LoadPreference" = $rdsserver.LoadPreference;
		}
	}
}


$farmhealth | select-object FarmName,Farmhealth,RDS_Hostname,RDS_Status,RDS_health,RDS_Available,RDS_Missing_Apps,RDS_LoadPreference

$Title = "RDS Farm Health"
$Header = "RDS Farm Health"
$Comments = "This is an overview of the health of the RDS farms"
$Display = "Table"
$Author = "Wouter Kursten"
$PluginVersion = 0.3
$PluginCategory = "View"