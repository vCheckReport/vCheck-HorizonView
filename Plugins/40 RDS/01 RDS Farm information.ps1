# Start of Settings
# End of Settings


$Farmoverview=@()

foreach ($farm in $farms){
	$farmstatus=$farm.data.Enabled 
	
	$ProvisioningStatus=$farm.AutomatedFarmData.VirtualCenterProvisioningSettings.enableprovisioning
	$source=$farm.source
	$type=$farm.type
	switch ($farmstatus){
		$True {$farmstatusoutput="Enabled"}
		$False {$farmstatusoutput="Disabled"}
		default {$farmstatusoutput="No farm Status available"}
		}

	if ($type -eq "AUTOMATED"){
		switch ($ProvisioningStatus){
			$True {$ProvisioningStatusoutput="Enabled"}
			$False {$ProvisioningStatusoutput="Disabled"}
			default {$ProvisioningStatusoutput="No farm Provisioning Status available"}
			}

		switch ($source){
			VIEW_COMPOSER {$sourceoutput="Linked Clones"}
			INSTANT_CLONE_ENGINE {$sourceoutput="Instant Clones"}
			default {$sourceoutput="No Source data available"}
			}

		$farmoverview+=New-Object PSObject -Property @{
			"Name" = $farm.data.name;
			"Displayname" = $farm.data.DisplayName;
			"Description" = $farm.data.Description;
			"Status" = $farmstatusoutput;
			"Provisioning" = $ProvisioningStatusoutput;
			"Type" = $farm.type;
			"Source" = $sourceoutput;
			"Max_Host_Sessions"=$farm.AutomatedFarmData.RdsServerMaxSessionsData.maxsessions;
			"Max_Host_Session_Type"=$farm.AutomatedFarmData.RdsServerMaxSessionsData.maxsessionstype;
			}
		}

	elseif ($farm.type -eq "MANUAL"){
		$farmoverview+=New-Object PSObject -Property @{
		"Name" = $farm.base.name;
		"Displayname" = $farm.base.DisplayName;
		"Description" = $farm.base.Description;
		"Status" = $farmstatusoutput;
		"Provisioning" = $ProvisioningStatusoutput;
		"Type" = $farm.type;
		"Max_Host_Sessions"=$farm.AutomatedFarmData.RdsServerMaxSessionsData.maxsessions;
		"Max_Host_Session_Type"=$farm.AutomatedFarmData.RdsServerMaxSessionsData.maxsessionstype;
		}
	}	
}
$farmoverview | select-object Name,Displayname,Description,Status,Provisioning,Type,Source,Max_Host_Session_Type,Max_Host_Sessions

$Title = "RDS Farm Overview"
$Header = "RDS Farm Overview"
$Comments = "These shows the configuration for the RDS farms"
$Display = "Table"
$Author = "Wouter Kursten"
$PluginVersion = 0.1
$PluginCategory = "View"
