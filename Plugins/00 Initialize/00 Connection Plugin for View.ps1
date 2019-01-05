$Title = "Connection settings for View"
$Author = "Wouter Kursten"
$PluginVersion = 0.2
$Header = "Connection Settings"
$Comments = "Connection Plugin for connecting to View"
$Display = "None"
$PluginCategory = "View"

# Start of Settings
# Please Specify the address of one of the connection servers or the address for the general View environment
$Server = "Servername"
# Maximum number of samples to gather for events
$MaxSampleVIEvent = 100000
# Please give the user account to connect to Connection Server
$hvcsUser= "username"															
# Please give the domain for the user to connect to Connection Server
$hvcsDomain = "domain"														

# End of Settings



# Credential file for the user to connect to the Connection Server
$hvcsPassword = get-content .\hvcs_Credentials.txt | convertto-securestring		


# Credential file for the User configured n View to connect to the Database
# only to be used pre-horizon 7.3
# $hvedbpassword=get-content .\hvedb_Credentials.txt | convertto-securestring   	

# Loading 
Import-Module VMware.VimAutomation.HorizonView
Import-Module VMware.VimAutomation.Core

# --- Connect to Horizon Connection Server API Service ---
$hvServer1 = Connect-HVServer -Server $server -User $hvcsUser -Password $hvcsPassword -Domain $hvcsDomain

# --- Get Services for interacting with the View API Service ---
$Services1= $hvServer1.ExtensionData



# --- Get Desktop pools
$poolqueryservice=new-object vmware.hv.queryserviceservice
$pooldefn = New-Object VMware.Hv.QueryDefinition
$pooldefn.queryentitytype='DesktopSummaryView'
$poolqueryResults = $poolqueryService.QueryService_Create($Services1, $pooldefn)
$pools = foreach ($poolresult in $poolqueryResults.results){$services1.desktop.desktop_get($poolresult.id)}

# --- Get RDS Farms

$Farmqueryservice=new-object vmware.hv.queryserviceservice
$Farmdefn = New-Object VMware.Hv.QueryDefinition
$Farmdefn.queryentitytype='FarmSummaryView'
$FarmqueryResults = $FarmqueryService.QueryService_Create($Services1, $Farmdefn)
$farms = foreach ($farmresult in $farmqueryResults.results){$services1.farm.farm_get($farmresult.id)}