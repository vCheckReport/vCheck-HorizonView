# Start of Settings
# End of Settings


$eventlist=@()

#}
#}
#$eventdbstatus | select Servername,Port,Status,Username,DatabaseName,TablePrefix,State,Error #
#
#$Title = "Event Database Status"
#$Header = "Event Database Status"
#$Comments = "These are the settings for the Event Database"
#$Display = "Table"
#$Author = "Wouter Kursten"
#$PluginVersion = 0.1
#$PluginCategory = "View"
$eventdb=connect-hvevent -dbpassword "V#password1"
$lastevent=get-hvevent -hvdbserver $eventdb -timeperiod 'day'

$events=$lastevent.events | where {$_.severity -eq "AUDIT_SUCCESS"}

$events | select Username,Severity,EventTime,Module,Message


$eventlist+=New-Object PSObject -Property @{"Username" = $events.username;
								"Severity" = $events.severity;
								"EventTime" = $events.EventTime;
																"Module" = $events.Module;
																								"Message" = $events.Message;
}
$Title = "Event Overview"
$Header = "Event Overview"
$Comments = "These are the settings for the Event Database"
$Display = "Table"
$Author = "Hans Kraaijeveld/Niels Geursen"
$PluginVersion = 0.1
$PluginCategory = "View"