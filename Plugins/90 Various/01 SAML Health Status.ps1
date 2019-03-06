# Start of Settings
# End of Settings

$SAMLHealthoverview=@()
$SAMLAuthenticatorhealthlist=$services1.SAMLAuthenticatorHealth.SAMLAuthenticatorHealth_list()
foreach ($SAMLAuthenticatorhealth in $SAMLAuthenticatorhealthlist){
	$label=$SAMLAuthenticatorhealth.data.label
	$metadataurl=$SAMLAuthenticatorhealth.data.metadataURL
	foreach ($Connectionserver in $SAMLAuthenticatorhealth.connectionServerData){
		$SAMLHealthoverview+=New-Object PSObject -Property @{
		"Label" = $label;
		"metadataurl"=$metadataurl;
		"Connectionserver" = $Connectionserver.name;
		"Status" = $Connectionserver.Status;
		"Errormessage" = $Connectionserver.Error;
		"thumbprintAccepted" = $Connectionserver.thumbprintAccepted;
		"Certificate_Valid" = $Connectionserver.certificateHealth.valid;
		"Certificate_startTime" = $Connectionserver.certificateHealth.startTime;
		"Certificate_invalidReason" = $Connectionserver.certificateHealth.invalidReason;
		}
	}
}

$SAMLHealthoverview | select-object Label,metadataurl,Connectionserver,Status,Errormessage,thumbprintAccepted,Certificate_Valid,Certificate_startTime,Certificate_invalidReason

$Title = "SAML Connection Health Overview"
$Header = "SAML Connection Health Overview"
$Comments = "This shows the health for every saml connection on every connectionserver."
$Display = "Table"
$Author = "Wouter Kursten"
$PluginVersion = 0.3
$PluginCategory = "View"
