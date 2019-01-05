# Start of Settings
# End of Settings

$manualpoolstatus=@()
foreach ($pool in $pools){
	$poolname=$pool.base.name
	if ($pool.Type -like "Manual"){
		$queryservice=new-object vmware.hv.queryserviceservice
		$defn = New-Object VMware.Hv.QueryDefinition
		$defn.queryentitytype='MachineSummaryView'
		$filter = New-Object VMware.Hv.QueryFilterEquals -Property @{ 'memberName' = 'base.name'; 'value' = "$pool.base.name" }
		$queryResults = $queryService.QueryService_Create($Services1, $defn)
		$desktops=$queryResults.results
		$manualpoolstatus+=New-Object PSObject -Property @{
			"Name" = $Poolname;
			"Available" = ($desktops | where {$_.base.basicstate -eq "AVAILABLE"}).count;
			"Connected" = ($desktops | where {$_.base.basicstate -eq "CONNECTED"}).count;
			"Disconnected" = ($desktops | where {$_.base.basicstate -eq "DISCONNECTED"}).count;
			"Already_Used" = ($desktops | where {$_.base.basicstate -eq "ALREADY_USED"}).count;
			"Agent_Unreachable" = ($desktops | where {$_.base.basicstate -eq "AGENT_UNREACHABLE"}).count;
			"Error" = ($desktops | where {$_.base.basicstate -eq "ERROR"}).count;
		}
	}
}

$manualpoolstatus | select Name,Available,Connected,Disconnected,Already_Used,Agent_Unreachable,Error

$Title = "Manual Desktop Pool Status"
$Header = "Manual Desktop Pool Status"
$Comments = "These are the pools that have manual Desktops. Not all but the most common status's are counted."
$Display = "Table"
$Author = "Hackathon Team 1"
$PluginVersion = 0.2
$PluginCategory = "View"
