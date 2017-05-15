# Start of Settings
# End of Settings

$date=get-date
$datemaxexp=(get-date).adddays(30)
$conserverstatus=@()
$conservers=$services1.connectionserverhealth.connectionserverhealth_list()
foreach ($conserver in $conservers) {
if ($conserver.CertificateHealth.ExpirationTime -lt $date){
$expiring="Already Expired"
}
elseif ($conserver.CertificateHealth.ExpirationTime -lt $datemaxexp){
$expiring="Expiring in 30 days"
}
else {
$expiring="False"
}

$conserverstatus+=New-Object PSObject -Property @{"Name" = $conserver.name;
								"Status" = $conserver.Status;
								"Version" = $conserver.Version;
								"Build" = $conserver.Build
								"Certificate_Status" = $conserver.CertificateHealth.Valid;
								"Certificate_Expiration_Time" = $conserver.CertificateHealth.ExpirationTime;
								"Certificate_Expiring" = $expiring;
								"Certificate_Invalidation_Reason" = $conserver.CertificateHealth.InValidReason;
								
}
}
$conserverstatus | select name,Status,Version,Build,Certificate_Status,Certificate_Expiring,Certificate_Expiration_Time,Certificate_Invalidation_Reason 

$Title = "Connection Servers Status"
$Header = "Connection Servers Status"
$Comments = "These are the used Connection Servers"
$Display = "Table"
$Author = "Wouter Kursten"
$PluginVersion = 0.1
$PluginCategory = "View"