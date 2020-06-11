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
# GetFirewallLogs.ps1
# v1.0 190314 Initial creation - Gets the Windows Firewall logs
##################################################################################################################
#>

<#
.SYNOPSIS
    Get windows firewall logs
.DESCRIPTION
    Get machien windows firewall logs and print logs to screen.
#>
BEGIN
{
    $FireWallLog = "$env:windir\system32\LogFiles\Firewall\pfirewall.log"
    $targetLogFilePath = $baseDirectory + $env:computername + "_FirewallLogs" + (get-date -f _yyyyMMdd-HHmmss)+".log"
}
PROCESS
{
    if (Test-Path $FireWallLog) 
    {
        Get-content $FireWallLog | out-file $targetLogFilePath
        write-host "successfully export firewall logs to file:" 
        write-host $targetLogFilePath    
    }
    else 
    {
        Write-host "Firewall log file does not exists"
    }
}