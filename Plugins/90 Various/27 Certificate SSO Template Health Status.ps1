# Start of Settings
# End of Settings

$CertificateSSOTemplateHealthoverview=@()
$CertificateSSOTemplateHealthlist=$services1.CertificateSSOConnectorHealth.CertificateSSOConnectorHealth_list()
foreach ($CertificateSSOTemplateHealth in $CertificateSSOTemplateHealthlist){
	$Primary_enrollmentServer_stateReasons= [system.String]::Join(",", $CertificateSSOTemplateHealth.data.TemplateHealth.primaryEnrollmentServerStateReasons)
	$Secondary_enrollmentServer_stateReasons= [system.String]::Join(",", $CertificateSSOTemplateHealth.data.TemplateHealth.secondaryEnrollmentServerStateReasons)
	$CertificateSSOTemplateHealthoverview+=New-Object PSObject -Property @{
	"ConnectorName" = $CertificateSSOTemplateHealth.displayName;
	"Name" = $CertificateSSOTemplateHealth.data.TemplateHealth.name;
	"state" = $CertificateSSOTemplateHealth.data.TemplateHealth.state;
	"Primary_enrollmentServer_stateReasons" = $Primary_enrollmentServer_stateReasons;
	"Secondary_enrollmentServer_stateReasons" = $Secondary_enrollmentServer_stateReasons;
	}
}

$CertificateSSOTemplateHealthoverview | select-object ConnectorName,Name,State,Primary_enrollmentServer_stateReasons,Secondary_enrollmentServer_stateReasons

$Title = "True SSO Connector Template Health Overview"
$Header = "True SSO Connector Template Health Overview"
$Comments = "This shows the health for every True SSO Connector Template."
$Display = "Table"
$Author = "Wouter Kursten"
$PluginVersion = 0.1
$PluginCategory = "View"