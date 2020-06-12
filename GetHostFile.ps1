<##Disclaimer
The sample scripts are not supported under any Microsoft standard support program or service. 
The sample scripts are provided AS IS without warranty of any kind. 
Microsoft further disclaims all implied warranties including, without limitation, any implied warranties of merchantability or of fitness for a particular purpose. 
The entire risk arising out of the use or performance of the sample scripts and documentation remains with you. 
In no event shall Microsoft, its authors, or anyone else involved in the creation, production, or delivery of the scripts be liable for any damages whatsoever 
(including, without limitation, damages for loss of business profits, business interruption, loss of business information, or other pecuniary loss) 
arising out of the use of or inability to use the sample scripts or documentation, even if Microsoft has been advised of the possibility of such damages.
##>

<#
##################################################################################################################
# Microsoft MDATP CxE
#
# GetHostFiles.ps1
# v1.0 190314 Initial creation - Creates a copy of machine's hosts file
##################################################################################################################
#>

<#
.SYNOPSIS
    Get machine hosts file
.DESCRIPTION
    Creates a copy of machine's hosts file.
#>
BEGIN
{
    $HostsFilePath = "$env:SystemRoot\system32\Drivers\etc\hosts"
    $targetHostsFilePath = $baseDirectory + $env:computername + "_HostFile" + (get-date -f _yyyyMMdd-HHmmss)+".txt"
}
PROCESS
{
    if (Test-Path $HostsFilePath) 
    {
        Get-content $HostsFilePath | out-file $targetHostsFilePath
        write-host "successfully export host file to:" 
        write-host $targetHostsFilePath    
    }
    else 
    {
        Write-host "can not find hosts file"
    }
}