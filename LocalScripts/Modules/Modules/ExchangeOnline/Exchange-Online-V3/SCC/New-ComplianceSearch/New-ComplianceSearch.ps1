    #ReadMe
<#
    
.SYNOPSIS

    Adds a file name extension to a supplied name.


.DESCRIPTION
        
    To run Security and Compliance Center CMDLets,

    1. You must be connected to an the ExchangeOnlineManagment Modile 2.0.5 or later.

    2. You must then connect to the SCC via Connect-IPPSSession.

    3. Once these connections are established, the New-ComplianceSearch creates the peramiters for the search.

    4. Start-ComplianceSearch does just that, starts the search based on the New-ComplianceSearch peramiters.

    5. The Get-ComplianceSearch then checks if the ComplianceSearch has finished. 
    
    
.Notes

   
    

.PARAMETER Name
        
    Specifies the file name.

    
.PARAMETER Extension
        
    Specifies the extension. "Txt" is the default.


.INPUTS
        
    None. You cannot pipe objects to Add-Extension.


.OUTPUTS
        
    System.String. Add-Extension returns a string with the extension or file name.


.EXAMPLE
        
    PS> extension "File" "doc"
    File.doc


.LINK
        
    https://learn.microsoft.com/en-us/powershell/module/exchange/get-managementrole?view=exchange-ps

    https://learn.microsoft.com/en-us/powershell/module/exchange/new-compliancesearch?view=exchange-ps

    https://learn.microsoft.com/en-us/powershell/exchange/connect-to-scc-powershell?view=exchange-ps

    https://learn.microsoft.com/en-us/powershell/module/exchange/new-compliancesearch?view=exchange-ps

    https://learn.microsoft.com/en-us/powershell/module/exchange/start-compliancesearch?view=exchange-ps

    https://learn.microsoft.com/en-us/powershell/module/exchange/get-compliancecase?view=exchange-ps

    https://learn.microsoft.com/en-us/powershell/module/exchange/get-compliancesearchaction?view=exchange-ps


#>

#Script  



param (
[Parameter(Mandatory,HelpMessage='Enter a UserPrincical Name/Email')]
[string]$UserPrincipalName,


[Parameter(Mandatory,HelpMessage='Name the search.')]
[string]$SearchName,


[Parameter(Mandatory,HelpMessage='Type an email address or email subject.')]
[string]$EXLocation,


)


#Am I connected to ExchangeOnlinehe?

$PSSessionsName = Get-ConnectionInformation | Select-Object -Property "Name"

if ("$PSSessionsName" -match 'ExchangeOnline') 
{
    
}   
else
{
    Throw "Your are not connected to ExchangeOnline"
} 


#Am I connected to the Security and Compliance Center?

$SCCConnection = Get-PSSession | Select-Object -Property "ConnectionURI"

if ("$SCCConnection" -match 'compliance.protection') 
{
    
}   
else
{
    Write-Host "Your are not connected to the SCC...Connecting"

    Connect-IPPSSession -UserPrincipalName "$UserPrincipalName"
}


#Create Compliance Search peramiters

New-ComplianceSearch -Name "$SearchName" -ExchangeLocation "$EXLocation"


#Runs the New-ComplianceSearch CMDLet.

Start-ComplianceSearch -Identity "$SearchName"


#Check if Compliance Search is done.

Get-ComplianceSearch -Identity "$SearchName"


#Start Exporting the Compliance Search

New-ComplianceSearchAction "$SearchName" -Export -Format Fxstream


#Opens the URl to the MS Compliance Center in Edge as ClickOnce is required to download w/ the MS export tool upon first download and use.

Start-Process -FilePath "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" -ArgumentList "https://compliance.microsoft.com/contentsearchv2?viewid=export"









