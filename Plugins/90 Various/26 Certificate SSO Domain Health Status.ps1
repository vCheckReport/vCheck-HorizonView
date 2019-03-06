# Start of Settings
# End of Settings

$CertificateSSODomainHealthoverview=@()
$CertificateSSODomainHealthlist=$services1.CertificateSSOConnectorHealth.CertificateSSOConnectorHealth_list()
foreach ($CertificateSSODomainHealth in $CertificateSSODomainHealthlist){
	$Primary_enrollmentServer_stateReasons= [system.String]::Join(",", $CertificateSSODomainHealth.data.domainHealth.primaryEnrollmentServerStateReasons)
	$Secondary_enrollmentServer_stateReasons= [system.String]::Join(",", $CertificateSSODomainHealth.data.domainHealth.secondaryEnrollmentServerStateReasons)
	$CertificateSSODomainHealthoverview+=New-Object PSObject -Property @{
	"ConnectorName" = $CertificateSSODomainHealth.displayName;
	"domain" = $CertificateSSODomainHealth.data.domainHealth.domain;
	"dnsName" = $CertificateSSODomainHealth.data.domainHealth.dnsName;
	"state" = $CertificateSSODomainHealth.data.domainHealth.state;
	"Primary_enrollmentServer_stateReasons" = $Primary_enrollmentServer_stateReasons;
	"Secondary_enrollmentServer_stateReasons" = $Secondary_enrollmentServer_stateReasons;
	}
}

$CertificateSSODomainHealthoverview | select-object ConnectorName,domain,dnsName,state,Primary_enrollmentServer_stateReasons,Secondary_enrollmentServer_stateReasons

$Title = "True SSO Connector Domain Health Overview"
$Header = "True SSO Connector Domain Health Overview"
$Comments = "This shows the health for every True SSO Connector Domain."
$Display = "Table"
$Author = "Wouter Kursten"
$PluginVersion = 0.1
$PluginCategory = "View"