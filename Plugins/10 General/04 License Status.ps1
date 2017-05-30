# Start of Settings
# End of Settings

$licensestatus=@()

$license=($services1).license.license_get()
$licensestatus+=New-Object PSObject -Property @{"Licensed" = $license.Licensed;
								"LicenseKey" = $license.LicenseKey;
								"ExpirationTime" = $license.ExpirationTime;
								"ViewComposerEnabled" = $license.ViewComposerEnabled;
								"DesktopLaunchingEnabled" = $license.DesktopLaunchingEnabled;
								"ApplicationLaunchingEnabled" = $license.ApplicationLaunchingEnabled;
								"InstantCloneEnabled" = $license.InstantCloneEnabled;
								"UsageModel" = $license.UsageModel;
}								

$licensestatus | select Licensed,LicenseKey,ExpirationTime,ViewComposerEnabled,DesktopLaunchingEnabled,ApplicationLaunchingEnabled,InstantCloneEnabled,UsageModel

$Title = "License Status"
$Header = "License Status"
$Comments = "This is the license status information"
$Display = "Table"
$Author = "Wouter Kursten"
$PluginVersion = 0.1
$PluginCategory = "View"