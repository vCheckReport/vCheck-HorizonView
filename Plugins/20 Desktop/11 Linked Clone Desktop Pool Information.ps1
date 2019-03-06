# Start of Settings
# End of Settings

$automatedpoolstatus=@()
foreach ($pool in $pools){
	$poolname=$pool.base.name
	if ($pool.type -like "*automated*" -AND $pool.source -like "*VIEW_COMPOSER*"){
		$queryservice=new-object vmware.hv.queryserviceservice
		$defn = New-Object VMware.Hv.QueryDefinition
		$defn.queryentitytype='MachineSummaryView'
		$defn.filter=New-Object VMware.Hv.QueryFilterEquals -property @{'memberName'='base.desktop'; 'value'=$pool.id}
		$queryResults = $queryService.QueryService_Create($Services1, $defn)
		$desktops=$queryResults.results
		$automatedpoolstatus+=New-Object PSObject -Property @{
			"Name" = $Poolname;
			"Pool_Image" = $pool.automateddesktopdata.VirtualCenternamesdata.parentvmpath;
			"Pool_Snapshot" = $pool.automateddesktopdata.VirtualCenternamesdata.snapshotpath;
			"Desktop_Count" = ($desktops).count;
			"Available" = ($desktops | where {$_.base.basicstate -eq "AVAILABLE"}).count;
			"Connected" = ($desktops | where {$_.base.basicstate -eq "CONNECTED"}).count;
			"Disconnected" = ($desktops | where {$_.base.basicstate -eq "DISCONNECTED"}).count;
			"Maintenance" = ($desktops | where {$_.base.basicstate -eq "MAINTENANCE"}).count;
			"Provisioning" = ($desktops | where {$_.base.basicstate -eq "PROVISIONING"}).count;
			"Customizing" = ($desktops | where {$_.base.basicstate -eq "CUSTOMIZING"}).count;
			"Already_Used" = ($desktops | where {$_.base.basicstate -eq "ALREADY_USED"}).count;
			"Agent_Unreachable" = ($desktops | where {$_.base.basicstate -eq "AGENT_UNREACHABLE"}).count;
			"Error" = ($desktops | where {$_.base.basicstate -eq "ERROR"}).count;
			"Deleting" = ($desktops | where {$_.base.basicstate -eq "DELETING"}).count;
			"Provisioning_Error" = ($desktops | where {$_.base.basicstate -eq "PROVISIONING_ERROR"}).count;
		}
		$services1.QueryService.QueryService_DeleteAll()	
	}
}

$automatedpoolstatus | select Name,Pool_Image,Pool_Snapshot,Desktop_Count,Available,Connected,Disconnected,Maintenance,Provisioning,Customizing,Already_Used,Agent_Unreachable,Error,Deleting,Provisioning_Error
$Title = "Linked Clone Desktop Pool Status"
$Header = "Linked Clone Desktop Pool Status"
$Comments = "These are the pools that have floating linked clones. Not all but the most common status's are counted."
$Display = "Table"
$Author = "Hackathon Team 1"
$PluginVersion = 0.3
$PluginCategory = "View"
