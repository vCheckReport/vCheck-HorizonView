# Start of Settings
# End of Settings

function Get-HVUAGGatewayZone {
    param (
        [parameter(Mandatory = $true,
            HelpMessage = "Boolean for the GatewayZoneInternal property of the GatewayHealth.")]
        [bool]$GatewayZoneInternal
    )
    try {
        if ($GatewayZoneInternal -eq $False) {
            $GatewayZoneType="External"
        }
        elseif ($GatewayZoneInternal -eq $True) { 
            $GatewayZoneType="Internal"
        }
        # Return the results
        return $GatewayZoneType
    }
    catch {
        write-error -Message 'There was a problem determining the gateway zone type.' -Exception $_
    }
}

function Get-HVGatewayType {
    param (
        [parameter(Mandatory = $true,
            HelpMessage = "Boolean for the GatewayZoneInternal property of the GatewayHealth.")]
        [string]$HVGatewayType
    )
    try {
        if ($HVGatewayType -eq "AP") {
            $GatewayType="UAG"
        }
        elseif ($HVGatewayType -eq "F5") { 
            $GatewayType="F5 Load Balancer"
        }
        elseif ($HVGatewayType -eq "SG") { 
            $GatewayType="Security Server"
        }
        elseif ($HVGatewayType -eq "SG-cohosted") { 
            $GatewayType="Cohosted CS"
        }
        elseif ($HVGatewayType -eq "Unknown") { 
            $GatewayType="Unknownr"
        }
        # Return the results
        return $GatewayType
    }
    catch {
        write-error -Message 'There was a problem determining the gateway type.' -Exception $_
    }
}

$uaghealthstatuslist=@()
[array]$uaglist=$services1.Gateway.Gateway_List()
foreach ($uag in $uaglist){
    [VMware.Hv.GatewayHealthInfo]$uaghealth=$services1.GatewayHealth.GatewayHealth_Get($uag.id)
    $uaghealthstatuslist+=New-Object PSObject -Property @{
        "Podname" = $podname;
        "Gateway_Name" = $uaghealth.name;
        "Gateway_Address" = $uaghealth.name;
        "Gateway_GatewayZone" = (Get-HVUAGGatewayZone -GatewayZoneInternal ($uaghealth.GatewayZoneInternal));
        "Gateway_Version" = $uaghealth.Version;
        "Gateway_Type" = (Get-HVGatewayType -HVGatewayType ($uaghealth.type));
        "Gateway_Active" = $uaghealth.GatewayStatusActive;
        "Gateway_Stale" = $uaghealth.GatewayStatusStale;
        "Gateway_Contacted" = $uaghealth.GatewayContacted;
        "Gateway_Active_Connections" = $uaghealth.ConnectionData.NumActiveConnections;
        "Gateway_Blast_Connections" = $uaghealth.ConnectionData.NumBlastConnections;
        "Gateway_PCOIP_Connections" = $uaghealth.ConnectionData.NumPcoipConnections;
    }
}


$uaghealthstatuslist | select-object Podname,Gateway_Name,Gateway_Address,Gateway_GatewayZone,Gateway_Version,Gateway_Type,Gateway_Active,Gateway_Stale,Gateway_Contacted,Gateway_Active_Connections,Gateway_Blast_Connections,Gateway_PCOIP_Connections | sort-object Gateway_Name

$Title = "Gateway Health Overview"
$Header = "Gateway Health Overview"
$Comments = "This shows the health for all conected Gateways."
$Display = "Table"
$Author = "Wouter Kursten"
$PluginVersion = 0.1
$PluginCategory = "View"