$Title = "Connection settings for View"
$Author = "Wouter Kursten"
$PluginVersion = 0.1
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
$hvedbpassword=get-content .\hvedb_Credentials.txt | convertto-securestring   	

# Loading 
Import-Module VMware.VimAutomation.HorizonView
Import-Module VMware.VimAutomation.Core

# --- Connect to Horizon Connection Server API Service ---
$hvServer1 = Connect-HVServer -Server $server -User $hvcsUser -Password $hvcsPassword -Domain $hvcsDomain

# --- Get Services for interacting with the View API Service ---
$Services1= $hvServer1.ExtensionData

# --- Connect to the view events database ---
#$eventdb=connect-hvevent -dbpassword $hvedbpassword

# --- Get Desktop pools
$pools=get-hvpool | sort {$_.base.name}

