# Start of Settings
# End of Settings

$CertificateSSOcertificateServerHealthoverview=@()
$CertificateSSOconnectorHealthlist=$services1.CertificateSSOConnectorHealth.CertificateSSOConnectorHealth_list()
foreach ($CertificateSSOconnectorHealth in $CertificateSSOconnectorHealthlist){
	$connectorname=$CertificateSSOcertificateServerHealth.displayName
	foreach ($certificateserverhealth in $CertificateSSOconnectorHealth.data.certificateServerHealths){
		$Primary_enrollmentServer_stateReasons= [system.String]::Join(",", $certificateserverhealth.primaryEnrollmentServerStateReasons)
		$Secondary_enrollmentServer_stateReasons= [system.String]::Join(",", $certificateserverhealth.secondaryEnrollmentServerStateReasons)
		$CertificateSSOcertificateServerHealthoverview+=New-Object PSObject -Property @{
		"ConnectorName" = connectorname;
		"Name" = $certificateserverhealth.name;
		"state" = $certificateserverhealth.state;
		"Primary_enrollmentServer_stateReasons" = $Primary_enrollmentServer_stateReasons;
		"Secondary_enrollmentServer_stateReasons" = $Secondary_enrollmentServer_stateReasons;
		}
	}
}

$CertificateSSOcertificateServerHealthoverview | select-object ConnectorName,Name,State,Primary_enrollmentServer_stateReasons,Secondary_enrollmentServer_stateReasons

$Title = "True SSO Connector certificate Server Health Overview"
$Header = "True SSO Connector certificate Server Health Overview"
$Comments = "This shows the health for every True SSO Connector certificate Server."
$Display = "Table"
$Author = "Wouter Kursten"
$PluginVersion = 0.1
$PluginCategory = "View"