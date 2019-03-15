# Start of Settings
# End of Settings

$ADDomainHealthoverview=@()
$ADDomainHealthlist=$services1.ADDomainHealth.ADDomainHealth_list()
foreach ($ADDomainHealth in $ADDomainHealthlist){
	$netBiosName=$ADDomainHealth.netBiosName
	$dnsName=$ADDomainHealth.dnsName
	$nt4Domain=$ADDomainHealth.nt4Domain
	foreach ($Connectionserver in $ADDomainHealth.connectionServerState){
		$ADDomainHealthoverview+=New-Object PSObject -Property @{
		"netBiosName" = $netBiosName;
		"dnsName"=$dnsName;
		"nt4Domain"=$nt4Domain;
		"Connectionserver" = $Connectionserver.connectionServerName;
		"Status" = $Connectionserver.Status;
		"trustRelationship" = $Connectionserver.trustRelationship;
		"contactable" = $Connectionserver.contactable;
		}
	}
}

$ADDomainHealthoverview | select-object netBiosName,dnsName,nt4Domain,Connectionserver,Status,trustRelationship,contactable

$Title = "AD Domain Health Overview"
$Header = "AD Domain Health Overview"
$Comments = "This shows the health for every AD Domain from every connectionserver."
$Display = "Table"
$Author = "Wouter Kursten"
$PluginVersion = 0.1
$PluginCategory = "View"
