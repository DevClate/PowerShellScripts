    #ReadMe
<#
    
    .DESCRIPTION
        
        Gets Reg Key Value.
    
    
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
        
        PS C:\Users\MEFP\Documents> Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore'

        RPSessionInterval              : 1
        FirstRun                       : 0
        LastIndex                      : 142
        SRInitDone                     : 1
        LastMainenanceTaskRunTimeStamp : 133068616886618662
        PSPath                         : Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsNT\CurrentVersion\SystemRestore
        PSParentPath                   : Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\WindowsNT\CurrentVersion
        PSChildName                    : SystemRestore
        PSProvider                     : Microsoft.PowerShell.Core\Registry

    .LINK
        
        [OnlineVersion](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/get-itemproperty?view=powershell-7.2)

#>

#Script

Write-Host "Checking for elevated permissions..."

if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
[Security.Principal.WindowsBuiltInRole] "Administrator")) {

Write-Warning "This Terminal is not running as Admin, open a Terminal console as an administrator and run this script again."
Break
}

else 
{

Write-Host "The Terminal is running in a administrator...Running Code" -ForegroundColor Green

}

#Reg changes require elevated terminal. 

#Make sure to keep the Registry:: before the actual Reg key.

Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore'