# Start of Settings
# End of Settings


$eventdbstatus=@()
$eventdb=$services1.EventDatabaseHealth.EventDatabaseHealth_get()
if ($eventdb.configured -eq $True){
$eventdbstatus+=New-Object PSObject -Property @{"Servername" = $eventdb.data.Servername;
								"Port" = $eventdb.data.Port;
								"Status" = $eventdb.data.State;
								"Username" = $eventdb.data.Username;
								"DatabaseName" = $eventdb.data.DatabaseName
								"TablePrefix" = $eventdb.data.TablePrefix;
								"State" = $eventdb.data.State;
								"Error" = $eventdb.data.Error;
}
}
$eventdbstatus | select Servername,Port,Status,Username,DatabaseName,TablePrefix,State,Error 

$Title = "Event Database Status"
$Header = "Event Database Status"
$Comments = "These are the settings for the Event Database"
$Display = "Table"
$Author = "Wouter Kursten"
$PluginVersion = 0.1
$PluginCategory = "View"