# Start of Settings
# End of Settings

$fullpoolstatus=@()
foreach ($pool in $pools){
$poolname=$pool.base.name
if ($pool.type -like "*automated*" -AND $pool.source -like "*VIRTUAL_CENTER*"){
$desktops=get-hvmachinesummary -pool $poolname
$fullpoolstatus+=New-Object PSObject -Property @{"Name" = $Poolname;
								"Template" = $pool.AutomatedDesktopData.VirtualCenterNamesData.TemplatePath;
								"Desktop_Count" = ($desktops).count;
								"Desktops_Unassigned" = ($desktops | where {$_.base.User -eq $null}).count;
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
}
}
$fullpoolstatus | select Name,Template,Desktop_Count,Desktops_Unassigned,Available,Connected,Disconnected,Maintenance,Provisioning,Customizing,Already_Used,Agent_Unreachable,Error,Deleting,Provisioning_Error
$Title = "Full Clone Desktop Pool Status"
$Header = "Full Clone Desktop Pool Status"
$Comments = "These are all pools with full clones and their most common counters"
$Display = "Table"
$Author = "Wouter Kursten"
$PluginVersion = 0.1
$PluginCategory = "View"