# Start of Settings
# End of Settings

$Pooloverview=@()
foreach ($pool in $pools){
	$poolstatus=$pool.DesktopSettings.Enabled 
	$ProvisioningStatus=$pool.AutomatedDesktopData.VirtualCenterProvisioningSettings.enableprovisioning
	$source=$pool.source
	switch ($poolstatus)
		{
			$True {$poolstatusoutput="Enabled"}
			$False {$poolstatusoutput="Disabled"}
			default {$poolstatusoutput="No Pool Status available"}
		}

	switch ($ProvisioningStatus)
		{
			$True {$ProvisioningStatusoutput="Enabled"}
			$False {$ProvisioningStatusoutput="Disabled"}
			default {$ProvisioningStatusoutput="No Pool Provisioning Status available"}
		}

	switch ($source)
		{
			VIRTUAL_CENTER {$sourceoutput="vCenter Managed Desktop"}
			FULL_CLONES {$sourceoutput="Full Clones"}
			VIEW_COMPOSER {$sourceoutput="Linked Clones"}
			INSTANT_CLONE_ENGINE {$sourceoutput="Instant Clones"}
			UNMANAGED {$sourceoutput="Non-vCenter"}
			RDS {$sourceoutput="RDS Desktops"}
			{$_ -eq "VIRTUAL_CENTER" -AND $pool.type -eq "Automated"} {$sourceoutput="Full Clones"}
			{$_ -eq "VIRTUAL_CENTER" -AND $pool.type -eq "MANUAL"} {$sourceoutput="Manually Added vCenter Managed Desktops"}
			default {$sourceoutput="No Source data available"}
		}

	if ($pool.type -eq "Automated"){
		$Automaticassignment=$pool.AutomatedDesktopData.UserAssignment.AutomaticAssignment
		switch ($Automaticassignment)
		{
			$TRUE {$Automaticassignmentoutput="Automatic"}
			$FALSE {$Automaticassignmentoutput="Manual"}
			default {$Automaticassignmentoutput="No Assignment Status Available"}
		}
		$Pooloverview+=New-Object PSObject -Property @{"Name" = $pool.base.name;
			"Displayname" = $pool.base.DisplayName;
			"Description" = $pool.base.Description;
			"Status" = $poolstatusoutput;
			"Provisioning" = $ProvisioningStatusoutput;
			"Type" = $pool.type;
			"Source" = $sourceoutput;
			"User_Assignment" = $pool.AutomatedDesktopData.UserAssignment.userassignment;
			"Assignment_Type" = $Automaticassignmentoutput;
			}
		}

	elseif ($pool.type -eq "MANUAL"){
		$Automaticassignment= $pool.manualdesktopdata.UserAssignment.AutomaticAssignment
		switch ($Automaticassignment)
		{
			$TRUE {$Automaticassignmentoutput="Automatic"}
			$FALSE {$Automaticassignmentoutput="Manual"}
			default {$Automaticassignmentoutput="No Assignment Status Available"}
		}
		$Pooloverview+=New-Object PSObject -Property @{"Name" = $pool.base.name;
		"Displayname" = $pool.base.DisplayName;
		"Description" = $pool.base.Description;
		"Status" = $poolstatusoutput;
		"Provisioning" = $ProvisioningStatusoutput;
		"Type" = $pool.type;
		"Source" = $sourceoutput;
		"User_Assignment" = $pool.manualdesktopdata.UserAssignment.UserAssignment;
		"Assignment_Type" = $Automaticassignmentoutput;
			}
		}	

	elseif ($pool.type -eq "RDS"){
		$source=($services1.farm.farm_get($pool.rdsdesktopdata.farm)).source
		$ProvisioningStatus=($services1.farm.farm_get($pool.rdsdesktopdata.farm)).automatedfarmdata.VirtualCenterProvisioningSettings.enableprovisioning
		switch ($source)
		{
			VIEW_COMPOSER {$sourceoutput="Linked Clones RDS Hosts"}
			INSTANT_CLONE_ENGINE {$sourceoutput="Instant Clones RDS Hosts"}
			default {$sourceoutput="Manually Added RDS Hosts"}
		}

		switch ($ProvisioningStatus)
		{
			$True {$ProvisioningStatusoutput="Enabled"}
			$False {$ProvisioningStatusoutput="Disabled"}
			default {$ProvisioningStatusoutput="N/A"}
		}

		$Pooloverview+=New-Object PSObject -Property @{"Name" = $pool.base.name;
		"Displayname" = $pool.base.DisplayName;
		"Description" = $pool.base.Description;
		"Status" = $poolstatusoutput;
		"Provisioning" = $ProvisioningStatusoutput;
		"Type" = ($services1.farm.farm_get($pool.rdsdesktopdata.farm)).type;
		"Source" = $sourceoutput;
		"User_Assignment" = "N/A";
		"Assignment_Type" = "N/A";
			}
		}
}

$Pooloverview | select Name,Displayname,Description,Status,Provisioning,Type,Source,User_Assignment,Assignment_Type
$Title = "Overview of all Pools"
$Header = "Overview of all Pools"
$Comments = "Gives an overview of the general status of all pools"
$Display = "Table"
$Author = "Wouter Kursten"
$PluginVersion = 0.1
$PluginCategory = "View"