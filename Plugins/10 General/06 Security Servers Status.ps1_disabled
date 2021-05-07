# Start of Settings
# End of Settings

$date=get-date
$datemaxexp=(get-date).adddays(30)
$secserverstatus=@()
$secservers=$services1.securityserverhealth.securityserverhealth_list()
foreach ($secserver in $secservers) {
if ($secserver.CertificateHealth.ExpirationTime -lt $date){
$expiring="Already Expired"
}
elseif ($secserver.CertificateHealth.ExpirationTime -lt $datemaxexp){
$expiring="Expiring in 30 days"
}
else {
$expiring="False"
}

$secserverstatus+=New-Object PSObject -Property @{"Name" = $secserver.name;
								"Status" = $secserver.Status;
								"Version" = $secserver.Version;
								"Build" = $secserver.Build
								"Certificate_Status" = $secserver.CertificateHealth.Valid;
								"Certificate_Expiration_Time" = $secserver.CertificateHealth.ExpirationTime;
								"Certificate_Expiring" = $expiring;
								"Certificate_Invalidation_Reason" = $secserver.CertificateHealth.InValidReason;
								
}
}
$secserverstatus | select name,Status,Version,Build,Certificate_Status,Certificate_Expiring,Certificate_Expiration_Time,Certificate_Invalidation_Reason 

$Title = "Security Servers Status"
$Header = "Security Servers Status"
$Comments = "These are the used Security Servers"
$Display = "Table"
$Author = "Wouter Kursten"
$PluginVersion = 0.1
$PluginCategory = "View"