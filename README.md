<p align="center">
  <img src="https://github.com/vCheckReport/vCheck-HorizonView/blob/master/Content/VMWare-Horizon-Icon.png"/>
</p>

<a name="Title">

# vCheck Daily Report for HorizonView



[Join the VMware Code and #vCheck channel on slack and ask questions here!](https://code.vmware.com/slack/)

|Navigation|
|-----------------|
|[What is vCheck-HorizonView](#About)|
|[About](#About)|
|[Features](#Features)|
|[Installing](#Installing)|
|[Enhancements](#Enhancements)|
|[Release Notes](#ReleaseNotes)|
|[Contributing](#Contributing)|
|[Plugins](#Plugins)|
|[Styles](#Styles)|
|[Jobs & Settings](#JobsSettings)|
|[More Info](#More)|


<a name="What">

# What is vCheck-View? #
vCheck-HorizonView is an View-focussed reporting tool that can give you a periodic (i.e. Daily) look into the health of your platform.
* This tools is based on the awesome [vCheck-vSphere](https://github.com/alanrenouf/vCheck-vSphere) project
* Initially developed against SQL 2014, vSphere 6.0, PowerCLI 6.5 and View 7.0.2
* This report REQUIRES [PowerCLI](https://www.vmware.com/support/developer/PowerCLI/) and [vmware.hv.helper](https://github.com/vmware/PowerCLI-Example-Scripts) installation
* This plugin also REQUIRES a connection to the SQL server for the event database
* If you have multiple Horizon View environments , create multiple copies of the vCheck-HorizonView folder

<a name="About">

# About vCheck
[*Back to top*](#Title)

vCheck is a PowerShell HTML framework script, the script is designed to run as a scheduled task before you get into the office to present you with key information via an email directly to your inbox in a nice easily readable format.

This script picks on the key known issues and potential issues scripted as plugins for various technologies written as Powershell scripts and reports it all in one place so all you do in the morning is check your email.

One of they key things about this report is if there is no issue in a particular place you will not receive that section in the email, for example if there are no datastores with less than 5% free space (configurable) then the disk space section in the virtual infrastructure version of this script, it will not show in the email, this ensures that you have only the information you need in front of you when you get into the office.

This script is not to be confused with an Audit script, although the reporting framework can also be used for auditing scripts too.  I don't want to remind you that you have 5 hosts and what there names are and how many CPUs they have each and every day as you don't want to read that kind of information unless you need it, this script will only tell you about problem areas with your infrastructure.


<a name="Features">

# What is checked for in the View version ?
[*Back to top*](#Title)

The following items are included as part of the vCheck NSX download, they are included as vCheck Plugins and can be removed or altered very easily by editing the specific plugin file which contains the data. vCheck Plugins are found under the Plugins folder.

For each check that's written, here's a brief description of what it does.

***
## Connection Plugin for View ##
### Function ###
* Uses the hvcs_credentials.txt file to connect to the configured Connection Broker and polls all pools.




<a name="Installing">

# Installing
[*Back to top*](#Title)

Download this project and copy the vCheck folder to the desired location, note the content structure, in particular the Plugins folder.

Before you can use vCheck-HorizonView, you need to create an HorizonView password txt file.

Use the following to create a password txt file

  ```
  Read-Host -AsSecureString | ConvertFrom-SecureString | Out-File 'hvcs_Credentials.txt'

  ```

This file will need to be created where the script runs.

Also in the connection plugin the Connection server, username and domainname need to be set. 
The username used for the eventdatabase is the one actually configured in your Horizon View environment.

Once the files are in the correct location and the credentials XML file has been created, you need to start the installer.
Open a PowerCLI window **AS AN ADMINISTRATOR** then run...
`    vCheck.ps1 -config`
...which will start the process of configuring your install. 

<a name="Enhancements">

# Enhancements
[*Back to top*](#Title)


In the meantime, don't hesitate to pop over to the [#vCheck channel on slack](https://code.vmware.com/slack/) and join in on active conversations about anything you see- or don't see- here!

# Credentials
[*Back to top*](#Title)
The credentials file can be created using the following:
$creds = get-credential
$creds | export-clixml c:\path\to\credsfile.xml

# Settings
[*Back to top*](#Title)

edit the 00 Initialize\00 Connection Plugin for View.ps1 file with the following
* $server = connectionserver.fqdn.com
* $credfile = c:\path\to\credsfile.xml

<a name="ReleaseNotes">

# Changelog
[*Back to top*](#Title)

* 06-05-2021 - replaced the password only credentials file with a credetials file holding both username and password


<a name="Contributing">

# Contributing
[*Back to top*](#Title)

See out [Contributions](CONTRIBUTING.md) guidelines

<a name="Plugins">

# Plugins
[*Back to top*](#Title)

## Suggested Plugins for Development ##
* Dashboard error status 
* Desktops with error (non-standard) status
* Compare the Snapshots that have been set to the ones actually used on desktops to see if recompose might not have run
* relation between Composer and vCenter 
* last use time for dedicated desktops 
* Event Database status
* Connection,composer,security server status
* Information and status about the various desktop pool types
* RDS farm status

Some of the above suggestions might have been taken from a [VMTN post](https://communities.vmware.com/message/2673396)

## Plugin Structure
This section describes the basic structure of a vCheck plugin so that you can write your own plugins for either private use, or to contribute to the vCheck project.

### Settings
Your plugin must contain a section for settings. This may be blank, or may contain one or more variables that must be defined for your plugin to determine how it operates.

**Examples**

No Settings
  ```
  # Start of Settings
  # End of Settings
  ```

Settings to define two variables
  ```
  # Start of Settings
  # Comment - presented as part of the setup wizard
  $variable = "value"
  # Second variable
  $variable2 = "value2"
  ...
  # End of Settings
  ```

### Required variables
Each plugin **must** define the following variables:
$Title - The display name of the plugin
$Header - the header of the plugin in the report
$Display - The format of the plugin (See Content section)
$Author - The author's name
$PluginVersion - Version of the plugin
$PluginCategory - The Category of the plugin

### Content
#### Report output
Anything that is written to stdout is included in the report. This should be either an object or hashtable in order to generate the report information.

#### $Display variable
- List
- Table
- Chart - Not currently merged to master

#### Plugin Template
  ```
  # Start of Settings
  # End of Settings

  # generate your report content here. Simple placeholder hashtable for the sake of example
  @{"Plugin"="Awesome"}

  $Title = "Plugin Template"
  $Header =  "Plugin Template"
  $Comments = "Comment about this awesome plugin"
  $Display = "List"
  $Author = "Plugin Author"
  $PluginVersion = 1.0
  $PluginCategory = "View"
  ```
## Table Formatting
Since v6.16, vCheck has supported Table formatting rules in plugins. This allows you to define a set of rules for data, in order to provide more richly formatted HTML reports.

### Using Formatting Rules

To use formatting rules, a `$TableFormat` variable must be defined in the module.

The `$TableFormat` variable is a Hastable, with the key being the "column" of the table that the rule should apply to.

The Value of the Hashtable is an array of rule. Each rule is a hashtable, with the Key being the expression to evaluate, and the value containing the formatting options.

### Formatting options

The Formatting options are made up of two comma-separated values:
 1. The scope of the formatting rule - "Row" to apply to the entire row, or "Cell" to only apply to that particular cell.
 2. A pipe-separated HTML attribute, and value. E.g. class|green to apply the "green" class to the HTML element specified in number 1.

### Examples

#### Example 1

Assume you have a CSS class named "green", which you want to apply to any compliant objects. Similarly, you have a "red" class that you wish to use to highlight non-compliant objects. We would define the formatting rules as follows:

`$TableFormat = @{"Compliant" = @(@{ "-eq $true" = "Cell,class|green"; }, @{ "-eq$false" = "Cell,class|red" })}`

Here we can see two rules; the first checks if the value in the Compliant column is equal to $true, in which case it applies the "green" class to the table cell (i.e.
element). The second rule applies when the compliant column is equal to $false, and applied the "red" class.

#### Example 2

Suppose you now want to run a report on Datastores. You wish to highlight datastores with less than 25% free space as "warning", those with free space less than 15% as "critical". To make them stand out more, you want to highlight the entire row on the report. You also wish to highlight datastores with a capacity less than 500GB as silver.

To achieve this, you could use the following:
```
$TableFormat = @{"PercentFree" = @(@{ "-le 25" = "Row,class|warning"; }, @{ "-le 15" = "Row,class|critical" }); "CapacityGB" = @(@{ "-lt 500" = "Cell,style|background-color: silver"})}
 ```
Here we see the rules that apply to two different columns, with rules applied to the values in a fashion similar to Example 1.

<a name="Styles">

# Styles
[*Back to top*](#Title)

Each style *must* implement a function named Get-ReportHTML, as this is what is called by vCheck to generate the HTML report.

An array of plugin results is passed to Get-ReportHTML, which contains the following properties:
* Title
* Author
* Version
* Details
* Display
* TableFormat
* Header
* Comments
* TimeToRun

Additionally, if the style is to define colours to be used by charts, the following variables need to be defined:
* `[string[]] $ChartColours` - Array containing HTML colours without the hash e.g. $ChartColours = @("377C2B", "0A77BA", "1D6325", "89CBE1")
* `[string] $ChartBackground` - HTML colour without the hash. e.g. "FFFFFF"
* `[string] $ChartSize` - YYYxZZZ formatted string - where YYY is horizontal size, and ZZZ is height. E.g. "200x200"

To include image resources, you may call Add-ReportResource, specifying CID and data. As these are not referenced by table formatting rules, this will need to be called with the `-Used $true` parameter.

<a name="JobsSettings">

# Jobs & Settings
[*Back to top*](#Title)

## Job XML Specifications

In order to use the `-Job` parameter, an XML configuration file is used.

The root element is `<vCheck>`, under this there are two elements:
* `<globalVariables>` element specifies the path to the file containing the vCheck settings (by default globalVariables.ps1)
* `<plugins>` element has a semi-colon separated attribute name path, which contains the path(s) to search for plugins contained in child `<plugin>` elements.

Each `<plugin>` element contains the plugin name.

### Config Example
  ```
  <vCheck>
    <globalVariables>GlobalVariables.ps1</globalVariables>
    <plugins path="plugins-vSphere">
       <plugin>00 Connection Plugin for vCenter.ps1</plugin>
       <plugin>03 Datastore Information.ps1</plugin>
       <plugin>11 VMs with over CPU Count LOL WRONG PATH.ps1</plugin>
       <plugin>99 VeryLastPlugin Used to Disconnect.ps1</plugin>
    </plugins>
  </vCheck>
  ```
## Export/Import Settings
This section describes how to import and export your vCheck settings between builds.

These functions were added to vCheckUtils.ps1 in June '14 (first release build TBD)

You can copy a newer version of vCheckUtils.ps1 to your existing build in order to use the new functions.

To utilize the new functions, simply dot source the vCheckUtils.ps1 file in a PowerShell console:
```
PS E:\scripts\vCheck-HorizonView> . .\vCheckUtils.ps1
```
This should load and list the functions available to you.
We will be focusing on Export-vCheckSettings and Import-vCheckSettings. If you do not see these listed, you will need a newer version of vCheckUtils.ps1.

### Example
Lets assume we have an existing build located at
`E:\Scripts\vCheck-HorizonView`

First lets rename the folder
`E:\Scripts\vCheck-HorizonView-old`

Now we can download the latest build, unblock the zip file and unpack to `E:\Scripts` leaving us with two builds in our Scripts directory - `vCheck-HorizonView-old` and `vCheck-HorizonView`

Next we'll export the settings from the old build - using PowerShell navigate to `E:\Scripts\vCheck-HorizonView-old` and dot source `vCheckUtils.ps1`

### Export Settings
Running `Export-vCheckSettings` will by default create a CSV file named `vCheckSettings.csv` in the current directory.
You can also specify a settings file
```
PS E:\scripts\vCheck-HorizonView-old> Export-vCheckSettings -outfile E:\MyvCheckSettings.csv
```

That's all there is to exporting your vCheck settings. Note that the settings file will be overwritten if you were to run the function again.

### Import Settings
To import your vCheck settings, in PowerShell navigate to the new build at `E:\Scripts\vCheck-HorizonView` and dot source `vCheckUtils.ps1` once again.

Here we have two options - if we run `Import-vCheckSettings` with no parameters it will expect the `vCheckSettings.csv` file to be in the same directory. If not found it will prompt for the full path to the settings CSV file.
The second option is to specify the path to the settings CSV file when running Import-vCheckSettings
```
PS E:\scripts\vCheck-HorizonView> Import-vCheckSettings -csvfile E:\MyvCheckSettings.csv
```
If new settings or plugins have been added to the new build you will be asked to answer the questions, similar to running the initial config. During the import, the initial config is disabled, so once the import is complete you are ready to run your new build.

<a name="More">

# More Info
[*Back to top*](#Title)

For more information please read here: http://www.virtu-al.net/vcheck-pluginsheaders/vcheck/

For an example HorizonView output (doesnt contain all info) click here http://virtu-al.net/Downloads/vCheck/vCheck.htm

