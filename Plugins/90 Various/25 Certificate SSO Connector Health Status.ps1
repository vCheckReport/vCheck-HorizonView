# Start of Settings
# End of Settings

$CertificateSSOConnectorHealthoverview=@()
$CertificateSSOConnectorHealthlist=$services1.CertificateSSOConnectorHealth.CertificateSSOConnectorHealth_list()
foreach ($CertificateSSOConnectorHealth in $CertificateSSOConnectorHealthlist){
	$Primary_enrollmentServer_stateReasons= [system.String]::Join(",", $CertificateSSOConnectorHealth.data.primaryEnrollmentServerHealth.stateReasons)
	$Secondary_enrollmentServer_stateReasons= [system.String]::Join(",", $CertificateSSOConnectorHealth.data.secondaryEnrollmentServerHealth.stateReasons)
	$CertificateSSOConnectorHealthoverview+=New-Object PSObject -Property @{
	"Displayname" = $CertificateSSOConnectorHealth.displayName;
	"enabled" = $CertificateSSOConnectorHealth.enabled;
	"overallState"= $CertificateSSOConnectorHealth.data.overallState;
	"Primary_enrollmentServer" = $CertificateSSOConnectorHealth.data.primaryEnrollmentServerHealth.dnsName;
	"Primary_enrollmentServer_State" = $CertificateSSOConnectorHealth.data.primaryEnrollmentServerHealth.state;
	"Primary_enrollmentServer_stateReasons" = $Primary_enrollmentServer_stateReasons;
	"Secondary_enrollmentServer" = $CertificateSSOConnectorHealth.data.primaryEnrollmentServerHealth.dnsName;
	"Secondary_enrollmentServer_State" = $CertificateSSOConnectorHealth.data.primaryEnrollmentServerHealth.state;
	"Secondary_enrollmentServer_stateReasons" = $Secondary_enrollmentServer_stateReasons;
	}
}

$CertificateSSOConnectorHealthoverview | select-object Displayname,enabled,overallState,Primary_enrollmentServer,Primary_enrollmentServer_State,Primary_enrollmentServer_stateReasons,Secondary_enrollmentServer,Secondary_enrollmentServer_State,Secondary_enrollmentServer_stateReasons

$Title = "True SSO Connector Health Overview"
$Header = "True SSO Connector Health Overview"
$Comments = "This shows the health for every True SSO Connector."
$Display = "Table"
$Author = "Wouter Kursten"
$PluginVersion = 0.1
$PluginCategory = "View"