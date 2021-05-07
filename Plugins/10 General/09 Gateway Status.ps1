# Start of Settings
# End of Settings

Function Convert-FromUnixDate ($UnixDate) {
	[timezone]::CurrentTimeZone.ToLocalTime(([datetime]'1/1/1970').AddSeconds($UnixDate))
 }

$date=get-date
$datemaxexp=(get-date).adddays(30)
$gatewaystatus=@()
$gateways=$services1.GatewayHealth.GatewayHealth_List()
foreach ($gateway in $gateways) {
	$lastcontact = (([System.DateTimeOffset]::FromUnixTimeMilliSeconds(($gateway.LastUpdatedTimestamp)).DateTime).ToString("s"))
	$gatewaystatus+=New-Object PSObject -Property @{"Name" = $gateway.name
		"Address" = $gateway.Address
		"Version" = $gateway.Version
		"Type" = $gateway.Type
		"Internal" = $gateway.GatewayZoneInternal
		"Gateway_Active" = $gateway.CertificateHealth.Valid
		"Gateway_Stale" = $gateway.CertificateHealth.ExpirationTime
		"Gateway_Contacted" = $expiring
		"Gateway_Last_Contact" = $lastcontact
	}
}
$secserverstatus | select name,Address,Version,Type,Internal,Gateway_Active,Gateway_Stale,Gateway_Contacted,Gateway_Last_Contact

$Title = "Gateways Status"
$Header = "Gateways Status"
$Comments = "These are the used configured gateways"
$Display = "Table"
$Author = "Wouter Kursten"
$PluginVersion = 0.1
$PluginCategory = "View"